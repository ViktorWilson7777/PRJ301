<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chapters</title>
</head>
<body>

<h1>Chapter / Level List</h1>

<a href="/chapters/create">Create Chapter</a>
<br><br>

<table border="1" cellpadding="10">
    <tr>
        <th>ID</th>
        <th>Course / Stage</th>
        <th>Title</th>
        <th>Description</th>
        <th>Order</th>
        <th>Action</th>
    </tr>

    <c:forEach var="ch" items="${chapters}">
        <tr>
            <td>${ch.id}</td>
            <td>${ch.course.title}</td>
            <td>${ch.title}</td>
            <td>${ch.description}</td>
            <td>${ch.orderIndex}</td>
            <td>
                <a href="/chapters/edit/${ch.id}">Edit</a>
                |
                <a href="/chapters/delete/${ch.id}"
                   onclick="return confirm('Are you sure you want to delete this chapter?')">
                    Delete
                </a>
            </td>
        </tr>
    </c:forEach>
</table>

<br>

<a href="/courses">Back to Courses</a>

</body>
</html>