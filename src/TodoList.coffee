define 'TodoList',
[
    './ViewInterface.coffee'
],
(ViewInterface) ->
    #afdadad
    class TodoList extends ViewInterface
        items = ['First todo']

        init: ->
            self = this
            this.render()
            document.querySelector('.todo-list-form').addEventListener('submit', this.addItem.bind(self))
            document.addEventListener('click', this.deleteItem.bind(self))
            document.addEventListener('click', this.editItem.bind(self))

        editItem: (e) ->
            s = @
            if (e.target.classList.contains('todo-item-text'))
                text = e.target.parentElement.dataset.key
                e.target.innerHTML = "<input name='edit-text' value='#{text}'/>"
                e.target.querySelector('input').focus()
                e.target.querySelector('input').onblur = (e) ->
                    items[items.indexOf(text)] = e.target.value
                    s.render()

        deleteItem: (e) ->
            if (e.target.classList.contains("delete-btn"))
                key = e.target.parentElement.dataset.key
                items.splice(items.indexOf(key), 1)
                @render()
        
        addItem: (e) ->
            e.preventDefault()
            formData = new FormData(e.target)
            items.push(formData.get('text'))
            e.target.reset()
            @render()
        

        renderItem: (text) ->
            element = document.createElement('li')
            element.innerHTML = 
            "<div data-key='#{text}'><span class='todo-item-text'>#{text}</span><button class='delete-btn'>Delete</button></div>"
            document.querySelector('.todo-list').appendChild(element)
        
        clearList: ->
            document.querySelector('.todo-list').innerHTML = ""

        render: ->
            this.clearList()
            for item in items
                this.renderItem(item)
