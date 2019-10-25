#  Singleton

1. There can be only one instance.
2. Trying to make another instance returns the existing instance.
3. Global state (glorified global variable)
4. Lives for the rest of the app's lifespan


#### In Swift: 1 & 3: very easy to do.

2 - this is a bit harder
* we make it impossible to create another instance.

### PokemonService

We will make this into a singleton as...

* we want a central point of networking
* that is as network and bandwidth-efficient as possible

* this fulfills this as it utilizes its own cache
* has its own URLSession
* has all the methods needed to perform its work.


### Singleton Syntax - 3 things.

1. make a static instance property to have a global access point
2. hide the initializer to prevent making another one possible
3. make it impossible to subclass.


### Benefits:

* VERY convenient

### Disadvantages:

* global variable
* violates all 4 pillars of OOP
* can't destroy a Singleton
* can become a large centralized data-dump.






