<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lessons</title>
</head>
<body>

<h1>Lesson / SubLevel List</h1>

<a href="/lessons/create">Create Lesson</a>
<br><br>

<table border="1" cellpadding="10">
    <tr>
        <th>ID</th>
        <th>Chapter / Level</th>
        <th>Type</th>
        <th>Title</th>
        <th>Description</th>
        <th>Order</th>
        <th>Content Data</th>
        <th>Action</th>
    </tr>

    <c:forEach var="l" items="${lessons}">
        <tr>
            <td>${l.id}</td>
            <td>${l.chapter.title}</td>
            <td>${l.type}</td>
            <td>${l.title}</td>
            <td>${l.description}</td>
            <td>${l.orderIndex}</td>
            <td>${l.contentData}</td>
            <td>
                <a href="/lessons/edit/${l.id}">Edit</a>
                |
                <a href="/lessons/delete/${l.id}"
                   onclick="return confirm('Are you sure you want to delete this lesson?')">
                    Delete
                </a>
            </td>
        </tr>
    </c:forEach>
</table>

<br>

<a href="/chapters">Back to Chapters</a>

</body>
</html>