define 'TodoList',
[
    './ViewInterface.coffee'
],
(ViewInterface) ->
    class TodoList extends ViewInterface
        items = ['First todo']
        todoListSelector = document.querySelector('.todo-list')
        init: ->
            _render()
            document.querySelector('.todo-list-form').addEventListener('submit', _addItem.bind(@))
            document.addEventListener('click', _deleteItem.bind(@))
            document.addEventListener('click', _editItem.bind(@))
            todoListSelector.addEventListener('DOMNodeRemoved', _onDestroy.bind(@))
        _onDestroy = ->
            document.querySelector('.todo-list-form').removeEventListener('submit', _addItem.bind(@))
            document.removeEventListener('click', _deleteItem.bind(@))
            document.removeEventListener('click', _editItem.bind(@))
        _editItem = (e) ->
            { target } = e
            if (target.classList.contains('todo-item-text'))
                text = target.parentElement.dataset.key
                target.innerHTML = "<input name='edit-text' value='#{text}'/>"
                inputSelector = target.querySelector('input')
                inputSelector.focus()
                inputSelector.onblur = (e) ->
                    items[items.indexOf(text)] = e.target.value
                    _render()
        _deleteItem = (e) ->
            { target } = e
            if (target.classList.contains("delete-btn"))
                itemKey = target.parentElement.dataset.key
                items.splice(items.indexOf(itemKey), 1)
                _render()
        _addItem = (e) ->
            e.preventDefault()
            formData = new FormData(e.target)
            items.push(formData.get('text'))
            e.target.reset()
            _render()
        _renderItem = (text) ->
            element = document.createElement('li')
            element.innerHTML = 
            "<li class='alist-group-item' data-key='#{text}'><span class='todo-item-text'>#{text}</span>
                <span class='badge badge-primary delete-btn badge-pill'>D</span>
            </li>"
            todoListSelector.appendChild(element)
        _clearList = ->
            todoListSelector.innerHTML = ""
        _render = ->
            _clearList()
            for item in items
                _renderItem(item)
