<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Course Form</title>
</head>
<body>

<h1>Course Form</h1>

<form action="/courses/save" method="post">

    <input type="hidden" name="id" value="${course.id}">

    <div>
        <label>Program:</label>
        <select name="programId">
            <c:forEach var="p" items="${programs}">
                <option value="${p.id}" ${course.program.id == p.id ? "selected" : ""}>
                        ${p.title}
                </option>
            </c:forEach>
        </select>
    </div>

    <br>

    <div>
        <label>Code:</label>
        <input type="text" name="code" value="${course.code}">
    </div>

    <br>

    <div>
        <label>Title:</label>
        <input type="text" name="title" value="${course.title}">
    </div>

    <br>

    <div>
        <label>Level:</label>
        <input type="text" name="level" value="${course.level}">
    </div>

    <br>

    <div>
        <label>Order Index:</label>
        <input type="number" name="orderIndex" value="${course.orderIndex}">
    </div>

    <br>

    <div>
        <label>Description:</label>
        <textarea name="description">${course.description}</textarea>
    </div>

    <br>

    <button type="submit">Save Course</button>

</form>

<br>

<a href="/courses">Back to Course List</a>

</body>
</html>