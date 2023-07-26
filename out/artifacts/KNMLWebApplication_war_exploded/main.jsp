<!DOCTYPE html>
<html lang="en">

<head>
    <%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Main</title>
    <link rel="stylesheet" type="text/css" href="/main.css">
    <c:set var="contextPath" value="${pageContext.request.contextPath}"/>
</head>

<body>
    <style>
        <%@include file="/stylesheets/main.css"%>
    </style>
    <div class="toolbar">
        <a>
            Kotlin Numerical Methods
        </a>
    </div>
    <form method="post" id="sample-form">
        <div class="gridcontainer">
            <div>
                <a>
                    Интегральные методы
                </a>
                <div class="rows_int">
                    <div>
                        <div class="action">
                            <input type="submit" name="Rectangle" value="Метод Прямоугольников">
                        </div>
                    </div>
                    <div>
                        <div class="action">
                            <input type="submit" name="Trapezoid" value="Метод Трапеций">
                        </div>
                    </div>
                    <div>
                        <div class="action">
                            <input type="submit" name="Simpson" value="Метод Симпсона">
                        </div>
                    </div>
                </div>
            </div>
            <div>
                <a>
                    Методы решения СЛАУ
                </a>
                <div class="rows_slau">
                    <div>
                        <div class="action">
                            <input type="submit" name="Gauss" value="Метод Гаусса">
                        </div>
                    </div>
                    <div>
                        <div class="action">
                            <input type="submit" name="Thomas" value="Метод Томаса">
                        </div>
                    </div>
                    <div>
                        <div class="action">
                            <input type="submit" name="Jacobi" value="Метод Якоби">
                        </div>
                    </div>
                    <div>
                        <div class="action">
                            <input type="submit" name="Zeidel" value="Метод Зейделя">
                        </div>
                    </div>
                </div>
            </div>
            <div>
                <a>
                    Методы разложения матриц
                </a>
                <div class="rows_decomp">
                    <div>
                        <div class="action">
                            <input type="submit" name="Eigen" value="Собственные значения">
                        </div>
                    </div>
                    <div>
                        <div class="action">
                            <input type="submit" name="LU" value="LU-разложение">
                        </div>
                    </div>
                    <div>
                        <div class="action">
                            <input type="submit" name="QR" value="QR-разложение">
                        </div>
                    </div>
                    <div>
                        <div class="action">
                            <input type="submit" name="SVD" value="SVD-разложение">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>

<script>

</script>