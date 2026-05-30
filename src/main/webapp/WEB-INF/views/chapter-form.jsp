<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chapter Form</title>
</head>
<body>

<h1>Chapter / Level Form</h1>

<form action="/chapters/save" method="post">

    <input type="hidden" name="id" value="${chapter.id}">

    <div>
        <label>Course / Stage:</label>
        <select name="courseId">
            <c:forEach var="c" items="${courses}">
                <option value="${c.id}" ${chapter.course.id == c.id ? "selected" : ""}>
                        ${c.title}
                </option>
            </c:forEach>
        </select>
    </div>

    <br>

    <div>
        <label>Title:</label>
        <input type="text" name="title" value="${chapter.title}">
    </div>

    <br>

    <div>
        <label>Description:</label>
        <textarea name="description">${chapter.description}</textarea>
    </div>

    <br>

    <div>
        <label>Order Index / Level Number:</label>
        <input type="number" name="orderIndex" value="${chapter.orderIndex}">
    </div>

    <br>

    <button type="submit">Save Chapter</button>

</form>

<br>

<a href="/chapters">Back to Chapter List</a>

</body>
</html>
