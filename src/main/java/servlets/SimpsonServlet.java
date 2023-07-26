package servlets;

import com.github.varenytsiamykhailo.knml.integralmethods.SimpsonMethod;
import com.github.varenytsiamykhailo.knml.util.results.DoubleResultWithStatus;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import toFormReadJson.IntegralAnswerData;
import toFormReadJson.IntegralData;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.Reader;



public class SimpsonServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        //System.out.println(req.getContextPath());
        ServletContext sc = getServletContext();
        sc.getRequestDispatcher("/Simpson.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        //System.out.println(req.getContextPath());

        StringBuilder body = new StringBuilder();
        char[] buffer = new char[1024];
        int readChars;
        try(Reader reader = req.getReader()){
            while ((readChars=reader.read(buffer))!=-1){
                body.append(buffer,0, readChars);
            }
        }
        // в body лежит json
        System.out.println(body);

        Gson gson = new Gson();

        IntegralData integral = gson.fromJson(String.valueOf(body), IntegralData.class);
        System.out.println(integral.func);
        System.out.println(integral.interval);
        System.out.println(integral.accur);

        DoubleResultWithStatus result = new SimpsonMethod().solveIntegralBySimpsonMethod(integral.interval.get(0),
                integral.interval.get(1), integral.accur, false, integral.func);

        IntegralAnswerData data = new IntegralAnswerData();

        data.ans = result.getDoubleResult();

        System.out.println(data.ans);

        Gson gsonBuild = new GsonBuilder().setPrettyPrinting().create();

        String json = gsonBuild.toJson(data);

        System.out.println(json);


        res.getWriter().write(json);
        //RequestDispatcher rd = req.getRequestDispatcher("/QR.jsp");
        //rd.include(req, res);


    }
}
