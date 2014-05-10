NRF-iOS-Notetaking-App
======================

Final project for COMS W3101

So I used the Apple resource documentation a lot for this assignment. Some of the code may look similar
to their examples because of that, specifically for the MFMailComposeViewController and the ImageSelectViewController.

I also relied on some of the demo code from class as a model for using delegates and implementing
delegate protocols.

For the keyboard toolbar, it took me a while to get the CGRectMake dimensions right and even longer to realize
I needed to use initWithFrame method for it because init wasn't cutting it.

My problem is that I couldn't get the text view in the editing/creating note view controller
to stay ahead of the keyboard, even though that these subviews are embedded in a scroll view. 
When I went to Apple's website the instructions and sample code involved NSNotifications 
and a convoluted explanation so I didn't implement that. This means that after several lines of
text in the content section of the edit view, the keyboard will obscure what you're actually typing.
This is the only flaw I could find with the code. 

Using the back buttons on the navigation controller do not save the content to a note in 
the controllers. You must use the save buttons to do this in each controller. Otherwise content
doesn't persist. 
