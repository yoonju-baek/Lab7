<%-- 
    Document   : users
    Created on : Mar 7, 2022, 9:19:42 PM
    Author     : Yoonju Baek
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Users</title>
        
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    </head>
    <body class="bg-light">       
        <div class="container-fluid my-3">
            <h1 class="text-center">Yoonju's User Management System</h1>
            <div class="row m-5">
                <div class="col">
                    <form action="user" method="post">
                        <input type="hidden" name="action" value="add">
                        <div class="d-grid gap-2 mx-auto ">
                            <h3 class="text-center text-primary">Add User</h3>
                            <span class="border border-info border-3 p-2">
                            <label for="a_email" class="form-label">Email</label>
                            <input type="email" class="form-control" id="a_email" name="a_email" required/>
                            <label for="a_firstname" class="form-label">First Name</label>
                            <input type="text" class="form-control" id="a_firstname" name="a_firstname" required/>
                            <label for="a_lastname" class="form-label">Last Name</label>
                            <input type="text" class="form-control" id="a_lastname" name="a_lastname" required/>
                            <label for="a_password" class="form-label">Password</label>
                            <input type="password" class="form-control" id="a_password" name="a_password" required/>
                            
                            <label for="a_role" class="form-label">Role</label>
                            <select id="a_role" name="a_role" class="form-select">
                                <c:forEach var="role" items="${roles}">
                                    <option value="${role.id}">${role.name}</option>
                                </c:forEach>
                            </select>
                            </span>
                        </div>
                        <div class="d-grid mx-auto m-2">
                        <button type="submit" class="btn btn-primary">Add</button>
                        </div>
                    </form>  
                     </div>
                    
                     <div class="col-7">
                     <h3 class="text-center text-primary">User List</h3>
                    <table class="table table-striped table-hover align-middle">
                        <thead>
                            <tr>
                                <th>E-mail</th>
                                <th>First name</th>
                                <th>Last name</th>
                                <th>Role</th>
                                <th>Active</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="user" items="${users}">
                                <tr>
                                    <td>${user.email}</td>
                                    <td>${user.firstName}</td>
                                    <td>${user.lastName}</td>
                                    <td>${user.role.name}</td>
                                    <td class="text-center">${user.active ? "Y" : "N"}</td>
                                    <td>
                                        <a href="user?action=edit&email=${user.email}">Edit</a>
                                        <a href="user?action=delete&email=${user.email}">Delete</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                     </div>     
                    
                    <div class="col">
                    <form action="user" method="post">
                        <input type="hidden" name="action" value="save"/>
                        <div class="d-grid gap-2 mx-auto">
                            <h3 class="text-center text-primary">Edit User</h3>
                            <span class="border border-info border-3 p-2">
                            <label for="e_email" class="form-label">Email</label>
                            <input type="email" class="form-control" id="e_email" name="e_email" value="${e_user.email}" required readonly/>
                            
                            <label for="e_firstname" class="form-label">First Name</label>
                            <input type="text" class="form-control" id="e_firstname" name="e_firstname" value="${e_user.firstName}" required/>
                            
                            <label for="e_lastname" class="form-label">Last Name</label>
                            <input type="text" class="form-control" id="e_lastname" name="e_lastname" value="${e_user.lastName}" required/>
                            
                            <label for="e_password" class="form-label">Password</label>
                            <input type="password" class="form-control" id="e_password" name="e_password" value="${e_user.password}" required/>
                            
                            <label for="e_role" class="form-label">Role</label>
                            <select id="e_role" name="e_role" class="form-select" required>
                                <c:forEach var="role" items="${roles}">
                                    <option value="${role.id}" ${role.id == e_user.role.id ? 'selected' : ''}>${role.name}</option>
                                </c:forEach>
                            </select>
                            <div class="form-check">
                            <label for="e_active" class="form-check-label">Active</label>
                            <input class="form-check-input" type="checkbox" id="e_active" name="e_active" ${e_user.active ? 'checked' : ''}/>
                             </div>
                            </span>
                        </div>
                        <div class="d-grid gap-2 mx-auto m-2">
                        <button type="submit" class="btn btn-primary">Save</button>
                        <button type="submit" class="btn btn-secondary">Cancel</button>
                        </div>
                        
                    </form>     
                </div>
            </div>
        </div>                                
    </body>
</html>
