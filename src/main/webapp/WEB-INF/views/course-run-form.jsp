<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Course Run Form</title>
</head>
<body>

<h1>Course Run Form</h1>

<form action="/course-runs/save" method="post">

    <input type="hidden" name="id" value="${courseRun.id}">

    <div>
        <label>Course:</label>
        <select name="courseId">
            <c:forEach var="c" items="${courses}">
                <option value="${c.id}" ${courseRun.course.id == c.id ? "selected" : ""}>
                        ${c.title}
                </option>
            </c:forEach>
        </select>
    </div>

    <br>

    <div>
        <label>Code:</label>
        <input type="text" name="code" value="${courseRun.code}">
    </div>

    <br>

    <div>
        <label>Status:</label>
        <select name="status">
            <option value="DRAFT" ${courseRun.status == "DRAFT" ? "selected" : ""}>DRAFT</option>
            <option value="ACTIVE" ${courseRun.status == "ACTIVE" ? "selected" : ""}>ACTIVE</option>
            <option value="CLOSED" ${courseRun.status == "CLOSED" ? "selected" : ""}>CLOSED</option>
        </select>
    </div>

    <br>

    <div>
        <label>Starts At:</label>
        <input type="datetime-local" name="startsAt" value="${courseRun.startsAt}">
    </div>

    <br>

    <div>
        <label>Ends At:</label>
        <input type="datetime-local" name="endsAt" value="${courseRun.endsAt}">
    </div>

    <br>

    <div>
        <label>Capacity:</label>
        <input type="number" name="capacity" value="${courseRun.capacity}">
    </div>

    <br>

    <button type="submit">Save Course Run</button>

</form>

<br>

<a href="/course-runs">Back to Course Run List</a>

</body>
</html>
