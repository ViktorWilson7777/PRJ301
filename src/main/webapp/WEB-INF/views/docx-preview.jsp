<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>DOCX Preview</title>
</head>
<body>

<h1>DOCX Preview</h1>

<form action="/docx-preview" method="post" enctype="multipart/form-data">

  <div>
    <label>Select DOCX file:</label>
    <input type="file" name="file" accept=".docx">
  </div>

  <br>

  <button type="submit">Preview DOCX</button>

</form>

<br>

<a href="/import-files">Back to Import Files</a>

<hr>

<c:if test="${not empty fileName}">
  <h2>File: ${fileName}</h2>
</c:if>

<c:if test="${not empty paragraphs}">
  <table border="1" cellpadding="8">
    <tr>
      <th>Index</th>
      <th>Text</th>
    </tr>

    <c:forEach var="p" items="${paragraphs}">
      <tr>
        <td>${p.index}</td>
        <td>${p.text}</td>
      </tr>
    </c:forEach>
  </table>
</c:if>

</body>
</html>