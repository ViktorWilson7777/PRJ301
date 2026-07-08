<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<layout:main pageTitle="AI Generated Questions">

<style>
    .quiz-shell { display: grid; grid-template-columns: 320px minmax(0, 1fr); gap: 18px; align-items: start; }
    .quiz-question { border: 1px solid #E2E8F0; border-radius: 12px; padding: 16px; background: #fff; margin-bottom: 14px; }
    .quiz-option { display: flex; gap: 10px; align-items: flex-start; padding: 10px 12px; border: 1px solid #E2E8F0; border-radius: 10px; margin-top: 8px; cursor: pointer; }
    .quiz-option:hover { border-color: #A29BFE; background: #F8F7FF; }
    .quiz-option.correct { border-color: #10B981; background: #ECFDF5; }
    .quiz-option.wrong { border-color: #EF4444; background: #FEF2F2; }
    .quiz-result { display: none; border-radius: 12px; padding: 16px; background: #F8FAFC; border: 1px solid #E2E8F0; }
    .quiz-empty { border: 1px dashed #CBD5E1; border-radius: 12px; padding: 32px; text-align: center; color: #64748B; background: #fff; }
    @media (max-width: 900px) { .quiz-shell { grid-template-columns: 1fr; } }
</style>

<div class="d-flex align-items-center justify-content-between mb-4">
    <p class="text-muted mb-0" style="font-size: 13px;">Learners can generate a multiple-choice quiz from any lesson, submit answers, and see results instantly.</p>
</div>

<div class="quiz-shell mb-4">
    <div class="stat-card">
        <h6 style="font-weight: 600; margin-bottom: 16px;"><i class="bi bi-stars me-1"></i> Generate Quiz</h6>

        <div class="mb-3">
            <label class="form-label" style="font-size: 12px;">Lesson</label>
            <select id="aiLessonId" class="form-select form-select-sm">
                <option value="">-- Select a Lesson --</option>
                <c:forEach var="l" items="${allLessons}">
                    <option value="${l.id}">[${l.type}] ${l.title}</option>
                </c:forEach>
            </select>
        </div>

        <div class="mb-3">
            <label class="form-label" style="font-size: 12px;">Question Count</label>
            <select id="quizCount" class="form-select form-select-sm">
                <option value="5">5 questions</option>
                <option value="3">3 questions</option>
                <option value="10">10 questions</option>
            </select>
        </div>

        <button id="btnGenerateQuiz" class="btn btn-lucy btn-sm w-100" onclick="generateAiQuiz()">
            <i class="bi bi-magic me-1"></i> Generate Quiz
        </button>

        <div id="aiLoading" class="text-center mt-3" style="display: none;">
            <div class="spinner-border spinner-border-sm text-primary" role="status"></div>
            <span style="font-size: 13px; margin-left: 8px;">Generating quiz...</span>
        </div>

        <div id="aiError" class="alert alert-danger mt-3 mb-0 py-2" style="display: none; font-size: 13px;"></div>
    </div>

    <div>
        <div id="quizResult" class="quiz-result mb-3"></div>
        <div id="quizContainer" class="quiz-empty">
            <i class="bi bi-ui-checks-grid" style="font-size: 28px;"></i>
            <div class="mt-2">Select a lesson and generate a quiz to start.</div>
        </div>
        <button id="btnSubmitQuiz" class="btn btn-outline-lucy btn-sm mt-3" style="display: none;" onclick="submitQuiz()">
            <i class="bi bi-check2-circle me-1"></i> Submit Answers
        </button>
    </div>
</div>

<div class="lucy-table">
    <c:choose>
        <c:when test="${empty questions}">
            <div class="empty-state">
                <i class="bi bi-chat-dots"></i>
                <p>No quiz questions yet. Generate a quiz above to save questions.</p>
            </div>
        </c:when>
        <c:otherwise>
            <table class="table mb-0">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Question</th>
                        <th>Lesson</th>
                        <th>Answer</th>
                        <th>Generated</th>
                        <th style="width:80px;">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="q" items="${questions}">
                        <tr>
                            <td><strong>#${q.id}</strong></td>
                            <td style="max-width: 420px;">${q.generatedQuestion}</td>
                            <td><c:if test="${q.lesson != null}">${q.lesson.title}</c:if></td>
                            <td><span class="badge-status badge-success">${q.correctOption}</span></td>
                            <td style="font-size: 12px;">${q.generatedAt}</td>
                            <td>
                                <button class="btn-action delete" onclick="confirmDelete('/ai-generated-questions/delete/${q.id}')"><i class="bi bi-trash"></i></button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>
</div>

<script>
var currentQuiz = [];
var hasSubmitted = false;

function generateAiQuiz() {
    var lessonId = document.getElementById('aiLessonId').value;
    var count = document.getElementById('quizCount').value;

    if (!lessonId) {
        showQuizError('Please select a lesson first.');
        return;
    }

    var btn = document.getElementById('btnGenerateQuiz');
    var loading = document.getElementById('aiLoading');
    var errorDiv = document.getElementById('aiError');
    var resultDiv = document.getElementById('quizResult');

    btn.disabled = true;
    loading.style.display = 'block';
    errorDiv.style.display = 'none';
    resultDiv.style.display = 'none';
    hasSubmitted = false;

    fetch('/api/ai/generate-quiz?lessonId=' + encodeURIComponent(lessonId) + '&count=' + encodeURIComponent(count), {
        method: 'POST'
    })
    .then(function(response) { return response.json(); })
    .then(function(data) {
        loading.style.display = 'none';
        btn.disabled = false;

        if (data.message) {
            showQuizError(data.message);
            return;
        }

        currentQuiz = data.questions || [];
        renderQuiz(currentQuiz, data.isMock);
    })
    .catch(function(err) {
        loading.style.display = 'none';
        btn.disabled = false;
        showQuizError('Failed to connect: ' + err.message);
    });
}

function renderQuiz(questions, isMock) {
    var container = document.getElementById('quizContainer');
    var submitBtn = document.getElementById('btnSubmitQuiz');

    if (!questions.length) {
        container.className = 'quiz-empty';
        container.innerHTML = '<i class="bi bi-exclamation-circle" style="font-size: 28px;"></i><div class="mt-2">No quiz questions generated.</div>';
        submitBtn.style.display = 'none';
        return;
    }

    container.className = '';
    container.innerHTML = '';

    if (isMock) {
        var mock = document.createElement('div');
        mock.className = 'alert alert-warning py-2';
        mock.style.fontSize = '13px';
        mock.textContent = 'Mock mode: add gemini.api.key to use the AI provider.';
        container.appendChild(mock);
    }

    questions.forEach(function(q, index) {
        var card = document.createElement('div');
        card.className = 'quiz-question';
        card.setAttribute('data-question-index', index);

        var title = document.createElement('div');
        title.style.fontWeight = '600';
        title.style.color = '#1E293B';
        title.textContent = (index + 1) + '. ' + (q.generatedQuestion || '');
        card.appendChild(title);

        ['A', 'B', 'C', 'D'].forEach(function(option) {
            var label = document.createElement('label');
            label.className = 'quiz-option';
            label.setAttribute('data-option', option);

            var input = document.createElement('input');
            input.type = 'radio';
            input.name = 'quiz_' + index;
            input.value = option;
            input.style.marginTop = '3px';

            var text = document.createElement('span');
            text.textContent = option + '. ' + (q['option' + option] || '');

            label.appendChild(input);
            label.appendChild(text);
            card.appendChild(label);
        });

        var explanation = document.createElement('div');
        explanation.className = 'quiz-explanation text-muted mt-2';
        explanation.style.cssText = 'display:none; font-size: 12px;';
        explanation.textContent = q.explanation || '';
        card.appendChild(explanation);

        container.appendChild(card);
    });

    submitBtn.style.display = 'inline-flex';
}

function submitQuiz() {
    if (!currentQuiz.length || hasSubmitted) {
        return;
    }

    var correct = 0;
    var unanswered = 0;

    currentQuiz.forEach(function(q, index) {
        var selected = document.querySelector('input[name="quiz_' + index + '"]:checked');
        var card = document.querySelector('[data-question-index="' + index + '"]');
        var selectedValue = selected ? selected.value : null;

        if (!selectedValue) {
            unanswered++;
        }

        if (selectedValue === q.correctOption) {
            correct++;
        }

        card.querySelectorAll('.quiz-option').forEach(function(label) {
            var option = label.getAttribute('data-option');
            if (option === q.correctOption) {
                label.classList.add('correct');
            } else if (option === selectedValue) {
                label.classList.add('wrong');
            }
            label.querySelector('input').disabled = true;
        });

        var explanation = card.querySelector('.quiz-explanation');
        if (explanation && explanation.textContent) {
            explanation.style.display = 'block';
        }
    });

    hasSubmitted = true;
    document.getElementById('btnSubmitQuiz').style.display = 'none';

    var resultDiv = document.getElementById('quizResult');
    resultDiv.style.display = 'block';
    resultDiv.innerHTML = '<div style="font-weight:700; color:#1E293B;">Score: ' + correct + '/' + currentQuiz.length + '</div>'
        + '<div class="text-muted" style="font-size: 13px;">Correct answers are highlighted in green. Your wrong answers are highlighted in red.'
        + (unanswered > 0 ? ' Unanswered: ' + unanswered + '.' : '') + '</div>';
}

function showQuizError(message) {
    var errorDiv = document.getElementById('aiError');
    errorDiv.textContent = message;
    errorDiv.style.display = 'block';
}
</script>

</layout:main>
