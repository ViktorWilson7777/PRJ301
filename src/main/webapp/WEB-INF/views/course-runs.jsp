<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Course Runs</title>
</head>
<body>

<h1>Course Run List</h1>

<a href="/course-runs/create">Create Course Run</a>
<br><br>

<table border="1" cellpadding="10">
    <tr>
        <th>ID</th>
        <th>Course</th>
        <th>Code</th>
        <th>Status</th>
        <th>Starts At</th>
        <th>Ends At</th>
        <th>Capacity</th>
        <th>Action</th>
    </tr>

    <c:forEach var="cr" items="${courseRuns}">
        <tr>
            <td>${cr.id}</td>
            <td>${cr.course.title}</td>
            <td>${cr.code}</td>
            <td>${cr.status}</td>
            <td>${cr.startsAt}</td>
            <td>${cr.endsAt}</td>
            <td>${cr.capacity}</td>
            <td>
                <a href="/course-runs/edit/${cr.id}">Edit</a>
                |
                <a href="/course-runs/delete/${cr.id}"
                   onclick="return confirm('Are you sure you want to delete this course run?')">
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
