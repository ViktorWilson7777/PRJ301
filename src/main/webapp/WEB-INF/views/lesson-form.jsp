<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lesson Form</title>
</head>
<body>

<h1>Lesson / SubLevel Form</h1>

<form action="/lessons/save" method="post">

    <input type="hidden" name="id" value="${lesson.id}">

    <div>
        <label>Chapter / Level:</label>
        <select name="chapterId">
            <c:forEach var="ch" items="${chapters}">
                <option value="${ch.id}" ${lesson.chapter.id == ch.id ? "selected" : ""}>
                        ${ch.title}
                </option>
            </c:forEach>
        </select>
    </div>

    <br>

    <div>
        <label>Type:</label>
        <select name="type">
            <option value="warmup" ${lesson.type == "warmup" ? "selected" : ""}>warmup</option>
            <option value="discussion" ${lesson.type == "discussion" ? "selected" : ""}>discussion</option>
            <option value="practice" ${lesson.type == "practice" ? "selected" : ""}>practice</option>
            <option value="wrapup" ${lesson.type == "wrapup" ? "selected" : ""}>wrapup</option>
        </select>
    </div>

    <br>

    <div>
        <label>Title:</label>
        <input type="text" name="title" value="${lesson.title}">
    </div>

    <br>

    <div>
        <label>Description:</label>
        <textarea name="description">${lesson.description}</textarea>
    </div>

    <br>

    <div>
        <label>Order Index / SubLevel Number:</label>
        <input type="number" name="orderIndex" value="${lesson.orderIndex}">
    </div>

    <br>

    <div>
        <label>Content Data JSON:</label>
        <br>
        <textarea name="contentData" rows="8" cols="80">${lesson.contentData}</textarea>
    </div>

    <br>

    <button type="submit">Save Lesson</button>

</form>

<br>

<a href="/lessons">Back to Lesson List</a>

</body>
</html>
