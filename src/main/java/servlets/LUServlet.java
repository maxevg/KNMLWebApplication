package servlets;

import com.github.varenytsiamykhailo.knml.util.LUDecomposition;
import com.github.varenytsiamykhailo.knml.util.Matrix;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import toFormReadJson.LUData;
import toFormReadJson.MatrixData;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.Reader;


public class LUServlet extends HttpServlet{

    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        //System.out.println(req.getContextPath());
        ServletContext sc = getServletContext();
        sc.getRequestDispatcher("/LU.jsp").forward(req, res);
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

        MatrixData matrix = gson.fromJson(String.valueOf(body), MatrixData.class);
        System.out.println(matrix.values);
        System.out.println(matrix.numOfRows);


        Matrix m1 = new Matrix(matrix.numOfRows, matrix.numOfRows);

        int counter = 0;

        for (int i = 0; i < matrix.numOfRows; i++) {
            for (int j = 0; j < matrix.numOfRows; j++) {
                m1.setElem(i, j, matrix.values.get(counter));
                counter += 1;
            }
        }

        LUDecomposition result = new LUDecomposition(m1);
        LUData data = new LUData();

        data.L = result.getLowerTriangularMatrix();
        data.U = result.getUpperTriangularMatrix();

        Gson gsonBuild = new GsonBuilder().setPrettyPrinting().create();

        String json = gsonBuild.toJson(data);

        System.out.println(json);


        System.out.println("L matrix: " + result.getLowerTriangularMatrix());
        System.out.println("U matrix: " + result.getUpperTriangularMatrix());

        res.getWriter().write(json);
        //RequestDispatcher rd = req.getRequestDispatcher("/QR.jsp");
        //rd.include(req, res);


    }

}
