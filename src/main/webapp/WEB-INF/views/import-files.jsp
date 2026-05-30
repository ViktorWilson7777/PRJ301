<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Import Files</title>
</head>
<body>

<h1>Import File List</h1>

<a href="/import-files/create">Create Import File Record</a>
<br><br>

<table border="1" cellpadding="10">
    <tr>
        <th>ID</th>
        <th>Course / Stage</th>
        <th>File Name</th>
        <th>Imported At</th>
        <th>Status</th>
        <th>Error Message</th>
        <th>Action</th>
    </tr>

    <c:forEach var="f" items="${importFiles}">
        <tr>
            <td>${f.id}</td>
            <td>${f.course.title}</td>
            <td>${f.fileName}</td>
            <td>${f.importedAt}</td>
            <td>${f.status}</td>
            <td>${f.errorMessage}</td>
            <td>
                <a href="/import-files/edit/${f.id}">Edit</a>
                |
                <a href="/import-files/delete/${f.id}"
                   onclick="return confirm('Are you sure you want to delete this import file record?')">
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
