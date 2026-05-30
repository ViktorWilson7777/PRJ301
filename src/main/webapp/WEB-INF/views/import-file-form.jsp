<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Import File Form</title>
</head>
<body>

<h1>Import File Form</h1>

<form action="/import-files/save" method="post">

  <input type="hidden" name="id" value="${importFile.id}">

  <div>
    <label>Course / Stage:</label>
    <select name="courseId">
      <c:forEach var="c" items="${courses}">
        <option value="${c.id}" ${importFile.course.id == c.id ? "selected" : ""}>
            ${c.title}
        </option>
      </c:forEach>
    </select>
  </div>

  <br>

  <div>
    <label>File Name:</label>
    <input type="text" name="fileName" value="${importFile.fileName}">
  </div>

  <br>

  <div>
    <label>Status:</label>
    <select name="status">
      <option value="PENDING" ${importFile.status == "PENDING" ? "selected" : ""}>PENDING</option>
      <option value="SUCCESS" ${importFile.status == "SUCCESS" ? "selected" : ""}>SUCCESS</option>
      <option value="FAILED" ${importFile.status == "FAILED" ? "selected" : ""}>FAILED</option>
    </select>
  </div>

  <br>

  <div>
    <label>Error Message:</label>
    <textarea name="errorMessage" rows="5" cols="60">${importFile.errorMessage}</textarea>
  </div>

  <br>

  <button type="submit">Save Import File</button>

</form>

<br>

<hr>

<h2>Upload DOCX File</h2>

<form action="/import-files/upload" method="post" enctype="multipart/form-data">

  <div>
    <label>Course / Stage:</label>
    <select name="courseId">
      <c:forEach var="c" items="${courses}">
        <option value="${c.id}">
            ${c.title}
        </option>
      </c:forEach>
    </select>
  </div>

  <br>

  <div>
    <label>DOCX File:</label>
    <input type="file" name="file" accept=".docx">
  </div>

  <br>

  <button type="submit">Upload DOCX</button>

</form>

<a href="/import-files">Back to Import File List</a>

</body>
</html>
