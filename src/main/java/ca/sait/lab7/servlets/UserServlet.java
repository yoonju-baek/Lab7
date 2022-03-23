package ca.sait.lab7.servlets;

import ca.sait.lab7.models.Role;
import ca.sait.lab7.models.User;
import ca.sait.lab7.services.RoleService;
import ca.sait.lab7.services.UserService;
import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Yoonju Baek
 */
public class UserServlet extends HttpServlet {

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserService userService = new UserService();
        RoleService roleService = new RoleService();
        
        try {
            List<User> users = userService.getAll();
            List<Role> roles = roleService.getAll();        
            
            request.setAttribute("users", users);
            request.setAttribute("roles", roles);
            
            String query = request.getQueryString();
            
            if(query != null && query.contains("delete")) {
                String email = request.getParameter("email").replaceAll(" ", "+");
                
                userService.delete(email);
                
                response.sendRedirect("user");
                return;
            }
            if(query != null && query.contains("edit")) {
                String email = request.getParameter("email").replaceAll(" ", "+");
                
                User user = userService.get(email);
                request.setAttribute("e_user", user);
            } 
            
            getServletContext().getRequestDispatcher("/WEB-INF/users.jsp").forward(request, response);
        } catch (Exception ex) {
            Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
      
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserService userService = new UserService();
        RoleService roleService = new RoleService();
        
        String email = "";
        String firstname = "";
        String lastname = "";
        String password = "";
        boolean active = false;
        int roleId = 0;
        
        try {         
            String action = request.getParameter("action");

            if(action != null && action.equals("add")) {
                email = request.getParameter("a_email");
                firstname = request.getParameter("a_firstname");
                lastname = request.getParameter("a_lastname");
                password = request.getParameter("a_password");
                roleId = Integer.parseInt(request.getParameter("a_role"));
                
                Role role = new Role(roleId, null);
            
                userService.insert(email, true, firstname, lastname, password, role);
            }
            else if(action != null && action.equals("save")) {
                email = request.getParameter("e_email");
                firstname = request.getParameter("e_firstname");
                lastname = request.getParameter("e_lastname");
                password = request.getParameter("e_password");
                active = (request.getParameter("e_active") != null);
                
                roleId = Integer.parseInt(request.getParameter("e_role"));

                Role role = new Role(roleId, null);
            
                userService.update(email, active, firstname, lastname, password, role);
            }
            else if(action != null && action.equals("reset")) {
                response.sendRedirect("user");
                return;
            }
            
            List<User> users = userService.getAll();
            List<Role> roles = roleService.getAll();        
            
            request.setAttribute("users", users);
            request.setAttribute("roles", roles);
            
            getServletContext().getRequestDispatcher("/WEB-INF/users.jsp").forward(request, response);
        } catch (Exception ex) {
                Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
