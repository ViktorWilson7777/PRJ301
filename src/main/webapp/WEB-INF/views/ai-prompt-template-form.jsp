<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>AI Prompt Template Form</title>
</head>
<body>

<h1>AI Prompt Template Form</h1>

<form action="/ai-prompt-templates/save" method="post">

    <input type="hidden" name="id" value="${template.id}">

    <div>
        <label>Lesson / SubLevel:</label>
        <select name="lessonId">
            <c:forEach var="l" items="${lessons}">
                <option value="${l.id}" ${template.lesson.id == l.id ? "selected" : ""}>
                        ${l.title}
                </option>
            </c:forEach>
        </select>
    </div>

    <br>

    <div>
        <label>Prompt Type:</label>
        <select name="promptType">
            <option value="warmup" ${template.promptType == "warmup" ? "selected" : ""}>warmup</option>
            <option value="ice_breaker" ${template.promptType == "ice_breaker" ? "selected" : ""}>ice_breaker</option>
            <option value="discussion" ${template.promptType == "discussion" ? "selected" : ""}>discussion</option>
            <option value="follow_up" ${template.promptType == "follow_up" ? "selected" : ""}>follow_up</option>
            <option value="practice" ${template.promptType == "practice" ? "selected" : ""}>practice</option>
            <option value="wrapup" ${template.promptType == "wrapup" ? "selected" : ""}>wrapup</option>
        </select>
    </div>

    <br>

    <div>
        <label>Prompt Instruction:</label>
        <br>
        <textarea name="promptInstruction" rows="8" cols="80">${template.promptInstruction}</textarea>
    </div>

    <br>

    <div>
        <label>Active:</label>
        <input type="checkbox" name="active" value="true" ${template.isActive ? "checked" : ""}>
    </div>

    <br>

    <button type="submit">Save Template</button>

</form>

<br>

<a href="/ai-prompt-templates">Back to Template List</a>

</body>
</html>