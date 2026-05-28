<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Programs</title>
</head>
<body>
<h1>Program List</h1>

<table border="1" cellpadding="8">
    <tr>
        <th>ID</th>
        <th>Code</th>
        <th>Title</th>
        <th>Description</th>
        <th>Published</th>
        <th>Action</th>
    </tr>

    <c:forEach var="p" items="${programs}">
        <tr>
            <td>${p.id}</td>
            <td>${p.code}</td>
            <td>${p.title}</td>
            <td>${p.description}</td>
            <td>${p.isPublished}</td>
            <td>
                <a href="/programs/edit/${p.id}">Edit</a>
                |
                <a href="/programs/delete/${p.id}"
                   onclick="return confirm('Are you sure you want to delete this program?')">
                    Delete
                </a>
            </td>
        </tr>
    </c:forEach>
</table>
</body>
</html>