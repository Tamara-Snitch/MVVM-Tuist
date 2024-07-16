<strong>Для сборки проекта необходимо перейти в директорию проекта и набрать команды в терминале:</strong>
<ol>
<li><code>tuist install</code></li>
<li><code>tuist generate</code></li>
</ol>

<strong>Добавление новых модулей в проект:</strong>
<ol>
<li><code>tuist scaffold Module --name ModuleName</code>, также есть необязательные аргументы:
<ul>
<li>author: String</li>
<li>date: String - в формате "dd.MM.yyyy"</li>
<li>year: String - в формате "yyyy"</li>
<li>company: String</li>
</ul>
<li>В Project.swift внедрить новый модуль в аргумент функции Project.app</li>
<li>Использовать <code>tuist generate</code> для генерации файлов</li>
</ol>
