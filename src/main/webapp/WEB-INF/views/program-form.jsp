<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Program Form</title>
</head>
<body>

<h1>Program Form</h1>

<form action="/programs/save" method="post">

    <!-- Náº¿u Ä‘ang edit thÃ¬ cÃ³ id, náº¿u create má»›i thÃ¬ id rá»—ng -->
    <input type="hidden" name="id" value="${program.id}">

    <div>
        <label>Code:</label>
        <input type="text" name="code" value="${program.code}">
    </div>

    <br>

    <div>
        <label>Title:</label>
        <input type="text" name="title" value="${program.title}">
    </div>

    <br>

    <div>
        <label>Description:</label>
        <textarea name="description">${program.description}</textarea>
    </div>

    <br>

    <div>
        <label>Published:</label>
        <input type="checkbox" name="published" value="true" ${program.isPublished ? "checked" : ""}>
    </div>

    <br>

    <button type="submit">Save Program</button>

</form>

<br>

<a href="/programs">Back to Program List</a>

</body>
</html>
