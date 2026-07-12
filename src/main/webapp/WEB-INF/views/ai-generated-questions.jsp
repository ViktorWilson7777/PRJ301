<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<layout:main pageTitle="AI Speaking Questions">
<style>
    .ai-shell{display:grid;grid-template-columns:340px minmax(0,1fr);gap:18px;align-items:start}
    .search-select{position:relative}.search-results{position:absolute;z-index:30;top:100%;left:0;right:0;margin-top:4px;background:#fff;border:1px solid #DDE1EA;border-radius:8px;max-height:260px;overflow-y:auto;box-shadow:0 12px 28px rgba(16,24,40,.14);display:none}
    .search-results.open{display:block}.lesson-option{display:block;width:100%;border:0;border-bottom:1px solid #F0F2F5;background:#fff;text-align:left;padding:10px 12px;font-size:13px;color:#344054}
    .lesson-option:hover,.lesson-option:focus{background:#F4F3FF;color:#5145CD;outline:0}.lesson-option small{display:block;color:#98A2B3;margin-top:2px}
    .question-grid{display:grid;grid-template-columns:repeat(3,minmax(0,1fr));gap:12px}.question-card{border:1px solid #DDE1EA;border-radius:8px;padding:18px;background:#fff;min-height:170px;display:flex;flex-direction:column}
    .question-number{width:32px;height:32px;border-radius:8px;background:#F0EEFF;color:#5145CD;display:grid;place-items:center;font-weight:700;margin-bottom:14px}.question-text{font-size:15px;line-height:1.6;color:#1D2939;font-weight:600;flex:1}
    .copy-question{border:0;background:transparent;color:#6558E8;font-size:13px;font-weight:600;text-align:left;padding:8px 0 0}.result-empty{border:1px dashed #C8CEDA;border-radius:8px;background:#fff;min-height:230px;display:grid;place-items:center;text-align:center;color:#667085;padding:28px}
    .inline-note{border:1px solid;border-radius:8px;padding:10px 12px;font-size:13px}.note-info{background:#EFF8FF;border-color:#B2DDFF;color:#175CD3}.note-error{background:#FEF3F2;border-color:#FECDCA;color:#B42318}
    .history-scroll{max-height:430px;overflow-y:auto}.history-scroll thead{position:sticky;top:0;background:#F8FAFC;z-index:2}
    .toast-note{position:fixed;right:22px;bottom:22px;background:#172033;color:#fff;padding:11px 14px;border-radius:8px;font-size:13px;box-shadow:0 12px 30px rgba(0,0,0,.2);display:none;z-index:2000}
    @media(max-width:1000px){.ai-shell{grid-template-columns:1fr}.question-grid{grid-template-columns:1fr}}
</style>

<div class="ai-shell mb-4">
    <section class="stat-card">
        <h6 style="font-weight:700;margin-bottom:6px"><i class="bi bi-stars me-1"></i>Host prompt assistant</h6>
        <p class="text-muted" style="font-size:12px;line-height:1.55">Choose the current lesson. LUCY creates exactly three open questions for the host to ask a speaker.</p>

        <label class="form-label" for="lessonSearch">Lesson</label>
        <div class="search-select mb-3">
            <input id="lessonSearch" class="form-control" type="search" placeholder="Type to find a lesson..." autocomplete="off">
            <input id="aiLessonId" type="hidden">
            <div id="lessonResults" class="search-results">
                <c:forEach var="lesson" items="${allLessons}">
                    <button type="button" class="lesson-option" data-id="${lesson.id}" data-search="${lesson.title} ${lesson.type}">
                        <c:out value="${lesson.title}"/>
                        <small><c:out value="${lesson.type}"/> · Level <c:out value="${lesson.levelNumber}"/></small>
                    </button>
                </c:forEach>
            </div>
        </div>

        <label class="form-label" for="promptType">Speaking stage</label>
        <select id="promptType" class="form-select mb-3">
            <option value="warmup">Warm-up</option>
            <option value="discussion" selected>Discussion</option>
            <option value="follow_up">Follow-up</option>
            <option value="wrapup">Wrap-up</option>
        </select>

        <button id="generateButton" class="btn btn-lucy w-100" type="button">
            <i class="bi bi-magic me-1"></i>Generate 3 questions
        </button>
        <div id="aiLoading" class="text-center mt-3" style="display:none">
            <span class="spinner-border spinner-border-sm text-primary"></span>
            <span class="ms-2" style="font-size:13px">Preparing questions...</span>
        </div>
        <div id="aiError" class="inline-note note-error mt-3" style="display:none"></div>
        <div id="mockNote" class="inline-note note-info mt-3" style="display:none">Preview mode is active. Add an OpenRouter key to generate fresh AI questions.</div>
    </section>

    <section>
        <div id="questionEmpty" class="result-empty">
            <div><i class="bi bi-chat-square-quote" style="font-size:32px"></i><div class="mt-2">Search for a lesson and generate questions when the host needs inspiration.</div></div>
        </div>
        <div id="questionGrid" class="question-grid" style="display:none"></div>
    </section>
</div>

<section class="lucy-table">
    <div class="px-3 pt-3"><h6 style="font-weight:700">Recent speaking questions</h6></div>
    <c:choose>
        <c:when test="${empty questions}"><div class="empty-state"><i class="bi bi-chat-dots"></i><p>No speaking questions have been generated yet.</p></div></c:when>
        <c:otherwise>
            <div class="history-scroll">
                <table class="table mb-0">
                    <thead><tr><th>Question</th><th>Lesson</th><th>Stage</th><th>Used</th><th style="width:90px">Actions</th></tr></thead>
                    <tbody>
                    <c:forEach var="question" items="${questions}">
                        <tr>
                            <td style="max-width:520px"><c:out value="${question.generatedQuestion}"/></td>
                            <td><c:if test="${question.lesson != null}"><c:out value="${question.lesson.title}"/></c:if></td>
                            <td><span class="badge-status badge-info"><c:out value="${question.promptType}"/></span></td>
                            <td>${question.usedByModerator ? 'Yes' : 'No'}</td>
                            <td>
                                <a class="btn-action edit" href="${pageContext.request.contextPath}/ai-generated-questions/toggle-used/${question.id}" title="Mark used"><i class="bi bi-check2"></i></a>
                                <a class="btn-action delete" href="${pageContext.request.contextPath}/ai-generated-questions/delete/${question.id}" title="Delete"><i class="bi bi-trash"></i></a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:otherwise>
    </c:choose>
</section>
<div id="toastNote" class="toast-note" role="status"></div>

<script>
document.addEventListener('DOMContentLoaded',function(){
    const search=document.getElementById('lessonSearch'),hidden=document.getElementById('aiLessonId'),results=document.getElementById('lessonResults');
    const options=Array.from(results.querySelectorAll('.lesson-option')),button=document.getElementById('generateButton');

    function filterLessons(){
        const query=search.value.trim().toLowerCase();let visible=0;
        hidden.value='';
        options.forEach(function(option){const match=!query||option.dataset.search.toLowerCase().includes(query);option.style.display=match?'block':'none';if(match)visible++;});
        results.classList.toggle('open',visible>0);
    }
    search.addEventListener('focus',filterLessons);search.addEventListener('input',filterLessons);
    options.forEach(function(option){option.addEventListener('click',function(){hidden.value=option.dataset.id;search.value=option.childNodes[0].textContent.trim();results.classList.remove('open');});});
    document.addEventListener('click',function(event){if(!event.target.closest('.search-select'))results.classList.remove('open');});

    button.addEventListener('click',function(){
        const lessonId=hidden.value,error=document.getElementById('aiError'),loading=document.getElementById('aiLoading');
        if(!lessonId){error.textContent='Choose one lesson from the search results.';error.style.display='block';search.focus();return;}
        error.style.display='none';button.disabled=true;loading.style.display='block';
        fetch('${pageContext.request.contextPath}/api/ai/suggest-questions?lessonId='+encodeURIComponent(lessonId)+'&promptType='+encodeURIComponent(document.getElementById('promptType').value),{method:'POST'})
        .then(function(response){return response.json();})
        .then(function(data){if(data.message)throw new Error(data.message);renderQuestions(data.questions||[]);document.getElementById('mockNote').style.display=data.isMock?'block':'none';})
        .catch(function(err){error.textContent=err.message||'Questions could not be generated.';error.style.display='block';})
        .finally(function(){button.disabled=false;loading.style.display='none';});
    });
});

function renderQuestions(items){
    const grid=document.getElementById('questionGrid'),empty=document.getElementById('questionEmpty');grid.innerHTML='';
    items.slice(0,3).forEach(function(item,index){
        const card=document.createElement('article');card.className='question-card';
        const number=document.createElement('div');number.className='question-number';number.textContent=index+1;
        const text=document.createElement('div');text.className='question-text';text.textContent=item.generatedQuestion||'';
        const copy=document.createElement('button');copy.type='button';copy.className='copy-question';copy.innerHTML='<i class="bi bi-copy me-1"></i>Copy for the host';
        copy.addEventListener('click',function(){navigator.clipboard.writeText(text.textContent).then(function(){showToast('Question copied.');});});
        card.append(number,text,copy);grid.appendChild(card);
    });
    empty.style.display=items.length?'none':'grid';grid.style.display=items.length?'grid':'none';
}
function showToast(message){const toast=document.getElementById('toastNote');toast.textContent=message;toast.style.display='block';clearTimeout(window.lucyToastTimer);window.lucyToastTimer=setTimeout(function(){toast.style.display='none';},2200);}
</script>
</layout:main>
