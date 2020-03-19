define 'TodoList',
[
    './ViewInterface.coffee'
],
(ViewInterface) ->
    class TodoList extends ViewInterface
        items = ['First todo']
        todoListSelector = document.querySelector('.todo-list')
        formSelector = document.querySelector('.todo-list-form')

        init: ->
            _render()
            _initListeners()
        _initListeners = ->
            formSelector.addEventListener('submit', _addItem.bind(@))
            document.addEventListener('click', _deleteItem.bind(@))
            document.addEventListener('click', _editItem.bind(@))
            todoListSelector.addEventListener('DOMNodeRemoved', _onDestroy.bind(@))
        _onDestroy = ->
            formSelector.removeEventListener('submit', _addItem.bind(@))
            document.removeEventListener('click', _deleteItem.bind(@))
            document.removeEventListener('click', _editItem.bind(@))
        _editItem = (e) ->
            { target } = e
            if (target.classList.contains('edit-btn'))
                text = target.parentElement.dataset.key
                spanSelector = target.parentElement.querySelector('span.todo-item-text')
                spanSelector.innerHTML = 
                    "<textarea name='edit-text' value='#{text}'>#{text}</textarea>"
                target.innerHTML = "Confirm"
                inputSelector = target.parentElement.querySelector('textarea')
                inputSelector.focus()

                onConfirmEdit = (e) ->
                    items[items.indexOf(text)] = inputSelector.value
                    _render()
                    target.removeEventListener('click', onConfirmEdit)
                target.addEventListener('click', onConfirmEdit)
        _deleteItem = (e) ->
            { target } = e
            if (target.classList.contains("delete-btn"))
                itemKey = target.parentElement.dataset.key
                items.splice(items.indexOf(itemKey), 1)
                _render()
        _addItem = (e) ->
            e.preventDefault()
            formData = new FormData(e.target)
            console.log('execute')
            items.push(formData.get('text'))
            e.target.reset()
            _render()
        _renderItem = (text) ->
            element = document.createElement('li')
            element.innerHTML = _generateHtmlElement(text)
            todoListSelector.appendChild(element)
        _generateHtmlElement = (text) ->
            "<li class='list-group-item' data-key='#{text}'><span class='todo-item-text'>#{text}</span>                
                <button type='button' class='btn edit-btn btn-primary'>Edit</button>
                <button type='button' class='btn delete-btn btn-danger'>Delete</button>
            </li>"
        _clearList = ->
            todoListSelector.innerHTML = ""
        _render = ->
            _clearList()
            for item in items
                _renderItem(item)
