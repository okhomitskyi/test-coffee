define 'App',
[
    './TodoList.coffee',
    './ViewInterface.coffee',
    './main.scss',
    'bootstrap'
],
(TodoList, ViewInterface) ->
    class App
        @todoList: ViewInterface
        # Assumed that we construct different components and init them here
        # We can change their behaviour if set listeners inside App
        constructor: (@todoList) ->
        init: ->
            @todoList = new TodoList()
            @todoList.init()
    app = new App()
    app.init()