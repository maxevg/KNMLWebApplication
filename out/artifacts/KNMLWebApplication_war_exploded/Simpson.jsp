<!DOCTYPE html>
<html lang="en">

<head>
    <%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Integrals</title>
    <link rel="stylesheet" type="text/css" href="/integrals.css">
    <c:set var="contextPath" value="${pageContext.request.contextPath}"/>
</head>

<body>

    <style>
            <%@include file="/stylesheets/integrals.css"%>
        </style>

    <div class="toolbar">
        <a>
            Kotlin Numerical Methods
        </a>
    </div>
    <form method="post" id="sample-form">
        <div class="container">
            <div id="parentId" class="input_data">
                <div>
                     <a>Метод Симпсона</a>
                </div>
                <div>
                    <a>Введите функцию f(x):</a>
                    <nobr>
                        <input name="func" type="text" class="input_func" value required />
                    </nobr>
                </div>
                <div>
                    <a>Введите требуемую точность:</a>
                    <nobr>
                        <input name="accur" type="text" id="accur" class="input_accur" value required />
                    </nobr>
                </div>
                <div>
                    <a>Введите интервал:</a>
                    <nobr>
                        <input name="left" type="text" id="left" class="input_inter" value required />
                        <input name="right" type="text" id="right" class="input_inter" value required />
                    </nobr>
                </div>
            </div>
            <div class = "btns">
                <button type="submit" class="btn btn-secondary"> Рассчитать </button>
            </div>
            <div id="answer">
            </div>
        </div>
    </form>
</body>
</html>

<script>

    function removeAllChildren(parent){
        parent.innerHTML = '';
    }

    const sampleForm = document.querySelector('form#sample-form');
    const formElement = document.querySelector('form#sample-form');
    let left = document.getElementById("left")
    let right = document.getElementById("right")
    let accur = document.getElementById("accur")

    sampleForm.addEventListener("submit", async (e) => {
        e.preventDefault();

        if (isNaN(left.value) || isNaN(right.value) || isNaN(accur.value)){
            alert('Ошибка. Данные введены некорректно.')
            left.value = ''
            right.value = ''
            accur.value = ''
        }

        if (left.value > right.value) {
            alert('Ошибка. Интервал введен некорректно.')
            left.value = ''
            right.value = ''
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
            console.log(responseData.ans)

            removeAllChildren(document.getElementById("answer"))

            var div = document.createElement("div");

            div.innerHTML += "<nobr>Result: </nobr>"

            div.innerHTML += "<nobr>" + responseData.ans + " </nobr>"

            document.getElementById("answer").appendChild(div);

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

        const func = formDataObject.func

        const accur = formDataObject.accur

        const interval = [formDataObject.left, formDataObject.right]

        const output = {
            func,
            accur,
            interval
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