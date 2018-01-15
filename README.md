# iOS Swift Project BoilerPlate

This project intension is to layout a structure or pattern which should be followed while making an iOS Application.

By structring it is meant how we arrange the code in the Bundle and the Design Pattern we follow while writting the code.
It is advisable to follow a definite structure in the entire code as it helps in readability, scalability, future modifications, management and better understanding of the code.

In this BoilerPlate arrangement an example of MVVM (Model View View-Model) Design Pattern has been given under the group Sample App. In this a UI is seperated into four different groups.
1. Model
2. View
3. ViewModel
4. Controller

Then under each group comes their relative classes.

Developer can also go through how the code is arranged in Bundle.
In this example the code has been divided into four parts
1. Sample App: Where all the UI Related Classes are kept
2. Resourses: Where all the Resourses that are required by the app are kept.
3. Networking: Networking is kept outside as this is the important and core part of the app and the whole application is dependent on it.
4. Database: As Networking this also makes the important and a core part of the application so it is kept outside so it is easily accessible.

The developer can modifyi this example and suit it according to the needs.
The whole point of following this pattern is to allow better interpretation, readability, undersadability and accessibility of the code. By following this the code also remains open for easier future modifications and scaling. 
