<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>AI Prompt Templates</title>
</head>
<body>

<h1>AI Prompt Template List</h1>

<a href="/ai-prompt-templates/create">Create AI Prompt Template</a>
<br><br>

<table border="1" cellpadding="10">
    <tr>
        <th>ID</th>
        <th>Lesson / SubLevel</th>
        <th>Prompt Type</th>
        <th>Prompt Instruction</th>
        <th>Active</th>
        <th>Action</th>
    </tr>

    <c:forEach var="t" items="${templates}">
        <tr>
            <td>${t.id}</td>
            <td>${t.lesson.title}</td>
            <td>${t.promptType}</td>
            <td>${t.promptInstruction}</td>
            <td>${t.isActive}</td>
            <td>
                <a href="/ai-prompt-templates/edit/${t.id}">Edit</a>
                |
                <a href="/ai-prompt-templates/delete/${t.id}"
                   onclick="return confirm('Are you sure you want to delete this template?')">
                    Delete
                </a>
            </td>
        </tr>
    </c:forEach>
</table>

<br>

<a href="/lessons">Back to Lessons</a>

</body>
</html>
