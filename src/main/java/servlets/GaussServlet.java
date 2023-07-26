package servlets;

import com.github.varenytsiamykhailo.knml.systemsolvingmethods.GaussMethod;
import com.github.varenytsiamykhailo.knml.util.Matrix;
import com.github.varenytsiamykhailo.knml.util.Vector;
import com.github.varenytsiamykhailo.knml.util.results.VectorResultWithStatus;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import toFormReadJson.SlauAnswerData;
import toFormReadJson.SlauData;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.Reader;


public class GaussServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        //System.out.println(req.getContextPath());
        ServletContext sc = getServletContext();
        sc.getRequestDispatcher("/Gauss.jsp").forward(req, res);
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

        SlauData slau = gson.fromJson(String.valueOf(body), SlauData.class);
        System.out.println(slau.values);
        System.out.println(slau.right);
        System.out.println(slau.numOfRows);

        Matrix m1 = new Matrix(slau.numOfRows, slau.numOfRows);
        Vector v1 = new Vector(slau.numOfRows);

        int counter = 0;

        for (int i = 0; i < slau.numOfRows; i++) {
            for (int j = 0; j < slau.numOfRows; j++) {
                m1.setElem(i, j, slau.values.get(counter));
                counter += 1;
            }
            v1.setElem(i, slau.right.get(i));
        }

        VectorResultWithStatus result = new GaussMethod().solveSystemByGaussClassicMethod(m1.getElems(), v1.getElems(), true);

        SlauAnswerData data = new SlauAnswerData();

        data.ans = result.getVectorResult();
        data.succ = result.isSuccessful();
        if (Double.isNaN(data.ans.getElem(0))) {
            data.succ = false;
            for (int i = 0; i < slau.numOfRows; i++){
                data.ans.setElem(i, 0);
            }
        }
        //System.out.println(data.ans);
        //System.out.println(data.succ);
        System.out.println(result.getSolutionObject().getSolutionString());

        Gson gsonBuild = new GsonBuilder().setPrettyPrinting().create();

        String json = gsonBuild.toJson(data);

        System.out.println(json);


        res.getWriter().write(json);
        //RequestDispatcher rd = req.getRequestDispatcher("/QR.jsp");
        //rd.include(req, res);


    }

}
