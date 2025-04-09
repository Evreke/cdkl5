<#macro header title currentPage menu>
    <nav class="navbar navbar-expand-lg navbar-light fixed-top">
        <div class="container">
            <div class="row w-100">
                <!-- Левая колонка с логотипом -->
                <div class="col-auto d-flex align-items-center">
                    <a class="navbar-brand" href="/">
                        <img class="logo" src="/static/img/logo.svg" alt="Сообщество пациентов CDKL5">
                    </a>
                </div>

                <!-- Правая колонка с меню -->
                <div class="col d-flex justify-content-end">
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                            aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
                        <ul class="navbar-nav">
                            <#list menu as item>
                                <#if (item.children![])?size gt 0>
                                    <!-- Выпадающее меню -->
                                    <li class="nav-item dropdown">
                                        <a class="nav-link dropdown-toggle <#if currentPage?starts_with(item.path!"")>fw-bold</#if>"
                                           href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown"
                                           aria-expanded="false">
                                            ${item.title}
                                        </a>
                                        <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                                            <#list item.children as child>
                                                <li>
                                                    <a class="dropdown-item <#if currentPage == (child.path!"")>fw-bold inactive</#if>"
                                                       href="${child.path!""}">
                                                        ${child.title!"Без названия"}
                                                    </a>
                                                </li>
                                            </#list>
                                        </ul>
                                    </li>
                                <#else>
                                    <!-- Обычный пункт меню -->
                                    <li class="nav-item">
                                        <a class="nav-link <#if currentPage == (item.path!"")>fw-bold active<#else>inactive</#if>"
                                           href="${item.path!""}">
                                            ${item.title!"Без названия"}
                                        </a>
                                    </li>
                                </#if>
                            </#list>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </nav>
</#macro>