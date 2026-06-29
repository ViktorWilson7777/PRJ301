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

<<<<<<< Updated upstream
    <div>
        <label>Program:</label>
        <select name="programId">
            <c:forEach var="p" items="${programs}">
                <option value="${p.id}" ${course.program.id == p.id ? "selected" : ""}>
                        ${p.title}
                </option>
            </c:forEach>
        </select>
=======
                <div class="mb-3">
                    <label class="form-label">Title <span class="text-danger">*</span></label>
                    <input type="text" name="title" class="form-control" value="${course.title}" required placeholder="e.g. English Stage 1" />
                </div>

                <div class="mb-3">
                    <label class="form-label">Level</label>
                    <input type="text" name="level" class="form-control" value="${course.level}" placeholder="e.g. Beginner" />
                </div>

                <div class="mb-3">
                    <label class="form-label">Language</label>
                    <input type="text" name="language" class="form-control" value="${course.language}" placeholder="e.g. English" />
                </div>

                <div class="mb-3">
                    <label class="form-label">Order Index</label>
                    <input type="number" name="orderIndex" class="form-control" value="${course.orderIndex}" min="0" />
                </div>

                <div class="mb-4">
                    <label class="form-label">Description</label>
                    <textarea name="description" class="form-control" rows="3">${course.description}</textarea>
                </div>

                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-lucy"><i class="bi bi-check-lg me-1"></i> Save</button>
                    <a href="/courses" class="btn btn-light" style="border-radius: 8px;">Cancel</a>
                </div>
            </form>
        </div>
>>>>>>> Stashed changes
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