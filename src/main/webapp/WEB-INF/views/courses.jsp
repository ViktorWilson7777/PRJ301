<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Courses</title>
</head>
<body>

<h1>Course List</h1>

<a href="/courses/create">Create Course</a>
<br><br>

<table border="1" cellpadding="10">
    <tr>
        <th>ID</th>
        <th>Program</th>
        <th>Code</th>
        <th>Title</th>
        <th>Level</th>
        <th>Order</th>
        <th>Description</th>
        <th>Action</th>
    </tr>

    <c:forEach var="c" items="${courses}">
        <tr>
            <td>${c.id}</td>
            <td>${c.program.title}</td>
            <td>${c.code}</td>
            <td>${c.title}</td>
            <td>${c.level}</td>
            <td>${c.orderIndex}</td>
            <td>${c.description}</td>
            <td>
                <a href="/courses/edit/${c.id}">Edit</a>
                |
                <a href="/courses/delete/${c.id}"
                   onclick="return confirm('Are you sure you want to delete this course?')">
                    Delete
                </a>
            </td>
        </tr>
    </c:forEach>
</table>

<br>

<a href="/programs">Back to Programs</a>

</body>
</html>
