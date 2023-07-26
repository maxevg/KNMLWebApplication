<!DOCTYPE html>
<html lang="en">

<head>
    <%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Matrix</title>
    <link rel="stylesheet" type="text/css" href="/slau.css">
    <c:set var="contextPath" value="${pageContext.request.contextPath}"/>
</head>

<body>

    <style>
        <%@include file="/stylesheets/slau.css"%>
    </style>

    <div class="toolbar">
        <a>
            Kotlin Numerical Methods
        </a>
    </div>
    <form method="post" id="sample-form">
        <div class="container">
            <div>
                 <a>Метод Гаусса</a>
            </div>
            <div>
                  <a>Введите матрицу и вектор</a>
            </div>
            <div id="parentId">
                <div>
                    <nobr>
                        <input name="rows" type="text" class="input_mat" value required />
                        <input name="rows" type="text" class="input_mat" value required />
                        <input name="rows" type="text" class="input_mat" value required />
                        <input name="res" type="text" class="input_mat" value required />
                    </nobr>
                </div>
                <div>
                    <nobr>
                        <input name="rows" type="text" class="input_mat" value required />
                        <input name="rows" type="text" class="input_mat" value required />
                        <input name="rows" type="text" class="input_mat" value required />
                        <input name="res" type="text" class="input_mat" value required />
                    </nobr>
                </div>
                <div>
                    <nobr>
                        <input name="rows" type="text" class="input_mat" value required/>
                        <input name="rows" type="text" class="input_mat" value required />
                        <input name="rows" type="text" class="input_mat" value required />
                        <input name="res" type="text" class="input_mat" value required />
                    </nobr>
                </div>
            </div>
            <div class = "btns">
                <button onclick="return deleteField()" class="btn btn-secondary"> - </button>
                <button onclick="return addField()" class="btn btn-secondary"> + </button>
                <button onclick="return clearFields()" class="btn btn-secondary"> Clear </button>
                <button type="submit" class="btn btn-secondary"> Count </button>
            </div>
            <div id="answer">
            </div>
        </div>
    </form>
</body>
</html>


<script>
    var countOfFields = 3; // Текущее число полей
    var curFieldNameId = 3; // Уникальное значение для атрибута name
    var maxFieldLimit = 10; // Максимальное число возможных полей
    function deleteField() {
        if (countOfFields > 3) {
            removeAllChildren(document.getElementById("parentId"));

            countOfFields--;

            for(let i = 0; i < countOfFields; i++) {
                var div = document.createElement("div");
                for (let j = 0; j < countOfFields; j++) {
                    div.innerHTML += "<nobr><input name=\"rows\" type=\"text\" class=\"input_mat\" value required/> "
                }

                div.innerHTML += "<nobr><input name=\"res\" type=\"text\" class=\"input_mat\" value required /></nobr>"
                document.getElementById("parentId").appendChild(div);
                curFieldNameId++;
            }

        }
        // Возвращаем false, чтобы не было перехода по сслыке
        return false;
    }
    function removeAllChildren(parent){
        curFieldNameId = 1;
        parent.innerHTML = '';
    }
    function addField() {

        if (countOfFields >= maxFieldLimit) {
            alert("Число полей достигло своего максимума = " + maxFieldLimit);

            return false;
        }

        removeAllChildren(document.getElementById("parentId"))

        countOfFields++;

        for(let i = 0; i < countOfFields; i++) {
            var div = document.createElement("div");
            for (let j = 0; j < countOfFields; j++) {
                div.innerHTML += "<nobr><input name=\"rows\" type=\"text\" class=\"input_mat\" value required/> "
            }

            div.innerHTML += "<nobr><input name=\"res\" type=\"text\" class=\"input_mat\" value required /></nobr>"
            document.getElementById("parentId").appendChild(div);
            curFieldNameId++;
        }

        // Возвращаем false, чтобы не было перехода по сслыке*/
        return false;
    }


    function clearFields(){
        console.log(document.getElementsByClassName("input_mat"))

        var inputElements = document.getElementsByClassName("input_mat")

        for (var i = 0, max = inputElements.length; i < max; i++) {
            inputElements[i].value = ''
        }
        return false
    }

</script>

<script>
    const sampleForm = document.querySelector('form#sample-form');
    const formElement = document.querySelector('form#sample-form');
    let matrixData = document.getElementsByClassName('input_mat');


    sampleForm.addEventListener("submit", async (e) => {
        e.preventDefault();

        outer: for (let i = 0; i < matrixData.length; i++) {
            if (isNaN(matrixData[i].value)) {
                alert('Ошибка. Данные введены некорректно.')
                break outer;
            }
        }

        let form = e.currentTarget;
        console.log(form)
        let url = form.action;
        console.log(url)
        try {
            let formData = new FormData(form);
            console.log(formData)
            let responseData = await postFormFieldsAsJson({ url, formData });
            // console.log(responseData)
            let { serverDataResponse } = responseData;
            //console.log(responseData.ans.elems)
            //console.log(responseData.succ)

            removeAllChildren(document.getElementById("answer"))

            var div = document.createElement("div");
            if (responseData.succ) {
                div.innerHTML += "<nobr>Result: </nobr>"
                document.getElementById("answer").appendChild(div);

                for(let i = 0; i < countOfFields; i++) {
                    div.innerHTML += "<nobr>" + responseData.ans.elems[i] + " </nobr>"

                    document.getElementById("answer").appendChild(div);
                }
            }
            else {
                div.innerHTML += "<nobr>Система не имеет решения</nobr>"

                document.getElementById("answer").appendChild(div);
            }



        } catch (error) {
            console.error(error);
        }
    });

    async function postFormFieldsAsJson({ url, formData }) {

        const getFormJSON = (form) => {
                        const data = new FormData(form);
                        return Array.from(data.keys()).reduce((result, key) => {
                            if (result[key]) {
                                result[key] = data.getAll(key)
                                return result
                            }
                            result[key] = data.get(key);
                            return result;
                        }, {});
                    };


        const formDataObject = getFormJSON(formElement);
        console.log(formDataObject)

        const values = formDataObject.rows

        const right = formDataObject.res

        const numOfRows = countOfFields

        const output = {
            values,
            right,
            numOfRows
        }

        let formDataJsonString = JSON.stringify(output);
        console.log(formDataJsonString)
        let fetchOptions = {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
                Accept: "application/json",
            },
            body: formDataJsonString,
        };

        let res = await fetch(url, fetchOptions);

        if (!res.ok) {
            let error = await res.text();
            throw new Error(error);
        }
        return res.json();
    }

</script>