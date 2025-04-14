<#macro header title currentPage menu>
    <nav class="navbar navbar-expand-lg navbar-light fixed-top">
        <div class="container">
            <!-- Верхняя строка с лого и гамбургером -->
            <div class="d-flex flex-row justify-content-between w-100 align-items-center">
                <!-- Логотип -->
                <div class="d-flex align-items-center">
                    <div class="logo-container d-flex flex-column align-items-center">
                        <div class="main-text">CDKL5</div>
                        <span class="sub-text">Россия</span>
                    </div>
                </div>

                <!-- Кнопка меню для мобильных -->
                <button class="navbar-toggler collapsed d-lg-none"
                        type="button"
                        data-bs-toggle="collapse"
                        data-bs-target="#navbarNav"
                        aria-controls="navbarNav"
                        aria-expanded="false"
                        aria-label="Переключить навигацию">
                    <span class="navbar-toggler-icon"></span>
                </button>
            </div>

            <!-- Контейнер меню -->
            <div class="collapse navbar-collapse flex-lg-grow-0" id="navbarNav">
                <ul class="navbar-nav flex-column flex-lg-row mt-2 mt-lg-0 align-items-stretch">
                    <#list menu as item>
                        <#if (item.children![])?size gt 0>
                            <!-- Выпадающее меню -->
                            <li class="nav-item dropdown d-flex align-items-center">
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
                            <li class="nav-item d-flex align-items-center">
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
    </nav>
</#macro>