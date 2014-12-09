### Overview
<a id="overview" name="overview"></a>

AppKit is a rails engine for quickly building data based applications.
Applications that are primary for finding, editing, and visualizing data. These
applications can be rapidly built using a simple DSL without the need to write
views, controllers, or any real logic.

AppKit makes a number of assumptions for your project.

-   The application's flow will use basic restful actions. This means that the
    interaction with the data will be in the form of creating, editing,
    deleting, listing, and viewing record data.
-   The application's visual appearance and branding is not important. AppKit
    will automatically generate the visual apperance of the application.
    Although the views themselves can be overridden, visual customization goes
    against the purpose of the framework.
-   The models within the application are not separated by modules. Currently
    AppKit does not support handling models that exist in their own module.

<a name="how-it-works" id="how-it-works"></a>
#### How it works

AppKit automatically generates restful controllers and views, based on a
simple `DSL` and your model layouts. It builds controllers exactly how you would
using standard rails paradigms. It will build a restful controller for each of
your models with actions and views for INDEX, EDIT, NEW, CREATE, UPDATE, and
DELETE. These controllers or individual views can then be overridden to extend
functionality. The DSL also allows for minor functionality to be added with only
a few lines of code.

<a name="what-for" id="what-for"></a>
#### When should I use AppKit

AppKit was built to generate data aware application __extreamly__ rapidly. Its
intended use cases were transient internal tools that needed to be up quickly but
might not stick around too long or quickly prototyping an application  to have
something in use while developing a more robust system.

#### If I prototype with AppKit will I be locked into using it?

Negative ghostrider. AppKit is built to be overridable. You can slowly override
the controllers and views with your own custom code. Once Everything has been
overridden you can simply remove AppKit from the project. This allows you to have
a functional application up in minutes and in use while developing a more custom
solution.


