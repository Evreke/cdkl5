<h3>Новости</h3>
<ul class="list-group">
    <#if item??>
        <#list news as item>
            <li class="list-group-item">
                <h5>${item.title}</h5>
                <p>${item.description}</p>
                <small>${item.date}</small>
            </li>
        </#list>
    </#if>
</ul>