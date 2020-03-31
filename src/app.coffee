define 'App',
[
    './components/TodoList/TodoList.coffee',
    './main.scss',
    'bootstrap'
],
(TodoList) ->
    class App

        @todoList

        # Assumed that we construct different components and init them here
        # We can change their behaviour if set listeners inside App
        constructor: (@todoList) ->
        
        init: ->
            @todoList = new TodoList()
            @todoList.init()

    app = new App()
    app.init()