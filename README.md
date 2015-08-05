## Envite

Envite is an app that aims to help people organise meet-ups between friends in a hassle-free manner. It aims to supplant the current practice of using Facebook events or instant messaging, which we feel is messy and slow.

Access the app: [here](https://young-plains-4770.herokuapp.com/)

Project blog: [here](https://awesomepipeline.wordpress.com/)

Youtube link to our ignition: [here](https://youtu.be/osQjStOAci0?t=2h35m44s)

Video for milestone 2: [here]()

## Code Status

[![Build Status](https://travis-ci.org/awesomepipeline/envite.svg)](https://travis-ci.org/awesomepipeline/envite)
[![Coverage Status](https://coveralls.io/repos/awesomepipeline/envite/badge.svg)](https://coveralls.io/r/awesomepipeline/envite)

## Planned Features

![](http://i.imgur.com/vwO0WNR.png "User Stories")

> [Milestone 1] This is a list of user stories that we have come up with.

In the first column of **must haves**, we have decided that the bare minimum a user is able to do is to create an event and to invite their friends. Their invited friends should also be able to vote on the venue and time chosen, and to suggest alternatives for others to vote on as well.

For the development of the application, Chunqi will be the technical lead, and be in charge of most of the technology stack that is used. Ming Xuan will be the front-end developer, taking charge of the design and user experience.

![](http://i.imgur.com/no00j6b.png "Mock Create Event Page")

> [Milestone 1] Mockup for the host to create an event

![](http://i.imgur.com/rltChEL.png "Mock Notifications page")

> [Milestone 1] List of events that the user has been invited to. Events will be presented in a "card" form, so it is clear to the user.

![](https://awesomepipeline.files.wordpress.com/2015/06/card-types-pending.png "New Mock Notifications Page")

> [Milestone 2] This is the next iteration mockup of our desired look and feel for our event cards. The main improvements over the previous version is in the presentation and the addition of intuitive call to actions presented.

![](https://awesomepipeline.files.wordpress.com/2015/06/event_card.png "Implemented Event Card")

> [Milestone 2] We have currently implemented the event card concept which can be seen when a host views his / her events under *My Events*. As this card is meant for tiling to present the list of all events created by the logged in user, we feel that it is more appropriate to present a summary of the responses at the bottom rather than having avatars show for the attendees. In order to see more details in an expanded view, click the *View Details* button.

![](https://awesomepipeline.files.wordpress.com/2015/06/event_card_full.png "Implemented Detailed Event Card")

> [Milestone 2] This is what the host sees when going into a detailed view of his / her event. We present colour coded avatars of all the friends invited and the host will be able to tell who has responded positively (green), negatively (red) or has yet to respond (yellow). Other relevant information such as suggestions from invitees and a message thread dedicated to this event is presented in a tab panel at the very top of the event card.

![](https://awesomepipeline.files.wordpress.com/2015/06/admin_interface.png "Admin Interface")

> [Milestone 2] The administrative interface was fairly straight forward to implement and was often required during development when database values were accidentally steamrolled. There is an admin account in the live app but we will withhold the credentials to prevent um, unintended power crazes.

## User Stories For Milestone 3

### Facebook Login
This feature is under consideration because after looking at the [timeup](http://www.timeup.io/) app, we are evaluating if we should adopt their no account required model as it would decrease the friction from user signups (or privacy concerns with Facebook login).

### Google Maps Integration
Google maps was surprisingly easy to work with using their V3 Javascript API and thus was integrated ahead of schedule by Milestone 2.

### Suggestions Voting
This is a main feature that is proposed for the app but the desired implementation has yet to be found. How does one display a poll with potentially a dozen different options in a compact manner and yet remain informative? The problem is especially problematic with date & time values.

### Images
With the implementation of a event specific message thread, an image message type would not be too far-fetched to include. The question is whether we would be duplicating Whatsapp functionality too much and would scalability (aka having to start paying for Heroku) be affected if we would need to store user uploaded images.

## Proposed Level of Achievement

The level of achievement that we are aiming for with this project is Apollo 11. We list our requirements and their justifications below:

### Vostok

* [x] Attend the Liftoff workshop
* [ ] Log at least 130 hours each: [link](https://docs.google.com/spreadsheets/d/1dOT-cn-uX3mZf6EYptsL-psYxPBt36Sn5GNuU_TkWU4/edit?usp=sharing)
* [ ] Participate in Splashdown
* [x] Create a basic web application with CRUD capabilities
* [x] Complete peer-evaluation exercises
* [x] Show progress over all 3 milestones

### Gemini
* [x] Using alternative platform: Ruby on Rails (completed Milestone 1)
* [x] Add an administrative front-end (completed Milestone 2)
* [x] Input validation and exception handling: Rails strong parameters and prepared queries (completed Milestone 1)
* [x] Google Maps API (completed ~~Milestone 3~~ Milestone 2)

### Apollo 11
* [x] Use some form of version control: Git/GitHub
* [x] Technical extension: Unit testing (completed Milestones ~~2 &~~ 3)
* [x] Technical extension: Use of transactions and ensuring referential integrity in database storage (completed Milestone ~~2~~ 3)
* [x] Technical extension: Separate front and back end into Client-API model (completed milestone 3)
* [ ] Score at least 3 stars out of 4 on feedback and evaluations

## Milestones

By Milestone 1, we aim to have a working prototype of our project. A demo of the app can be reached [here](http://young-plains-4770.herokuapp.com). Currently implemented features are users and authentication as well as creating events and inviting other users.

By Milestone 2, we hope that the UI can be much more polished and that the app would offer a better user experience. ~~We also hope to integrate the Facebook login so that users would not need to register for another account on our platform.~~ We will be looking into alternative no account required models to allow frictionless user onboarding.

By Milestone 3, we hope to have carried out some usability tests to gather feedback on how to better improve the user experience.

## References Used

### Learning resources
* [Rails Guides](guides.rubyonrails.org) - all you need to code a Rails app
* [Restful Rails API, Just Add Water](http://blog.codelation.com/rails-restful-api-just-add-water/) - good starting point for a Rails based API
* [Devise](http://devise.plataformatec.com.br/) - flexible authentication solution for Rails based on Warden
* [StackOverflow](http://stackoverflow.com/) - All kinds of RoR and Ruby questions

### Development
* [Ruby on Rails](http://rubyonrails.org/) - providing the backend REST API for the application
* [Sublime Text 3](http://www.sublimetext.com/3) - generally beautiful text editor
* [Heroku](http://heroku.com) - deploying the demo of the application
* [Bootstrap 3](http://getbootstrap.com/) - responsive web design

### Project Ideation & Tracking
* [Trello](http://trello.com) - user stories and internal development tracking board
* [Wordpress](https://wordpress.com/) - Project blog and media hosting
* [Google Sheets](http://www.google.com/sheets/about/) - project log
* [Sketch](http://bohemiancoding.com/sketch/) - prototyping the user interface
