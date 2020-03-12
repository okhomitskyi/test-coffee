class App
    @todoList
    constructor: (@todoList) ->
    init: ->
        @todoList = new TodoList()
        @todoList.init()

    
app = new App()

app.init()