package servlets;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;


public class MainServlet extends HttpServlet {

    private Map<String, String> buttonToPage = new HashMap<String, String>(){{
        put("QR",       "/KNMLWebApplication/QR");
        put("LU",       "/KNMLWebApplication/LU");
        put("SVD",      "/KNMLWebApplication/SVD");
        put("Eigen",    "/KNMLWebApplication/Eigen");
        put("Gauss",    "/KNMLWebApplication/Gauss");
        put("Thomas",   "/KNMLWebApplication/Thomas");
        put("Jacobi",   "/KNMLWebApplication/Jacobi");
        put("Zeidel",   "/KNMLWebApplication/Zeidel");
        put("Rectangle", "/KNMLWebApplication/Rectangle");
        put("Trapezoid", "/KNMLWebApplication/Trapezoid");
        put("Simpson",  "/KNMLWebApplication/Simpson");
    }};

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        //System.out.println(req.getContextPath());
        ServletContext sc = getServletContext();
        sc.getRequestDispatcher("/main.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
//        System.out.println("kek kek kek");
//        System.out.println(req.getParameter("QR"));
//        System.out.println(req.getParameter("LU"));
//        System.out.println(req.getParameter("SVD"));

        String URL = null;

        for (String key : buttonToPage.keySet()) {
            if (!equalsWithNulls(req.getParameter(key))) {
                URL = buttonToPage.get(key);
                break;
            }
        }

        res.sendRedirect(URL);

    }

    public static boolean equalsWithNulls(String a) {
        return a == null;
    }
}