# Visitations

|Title|Description|
|-----|-----------|
|Rails Version|4.1.4|
|Gem Dependencies|none|

## The Setup

I was presented with a new challenge for a project I was working on. I needed to be able
to track the last time a user visited a project. Based on that last visited date, I needed
to be able to display a count of updates to the project since the user last visited it.

## The Players

To best replicate the situation I was in, I have recreated as much of the app as possible.
To that end, we have the following models:

- Users
- Projects
- Notes

Users have many projects. Projects have many notes. Notes belong to a user and a project.

## The Implementation

The association between projects and users was the easy part. Users visit projects so I 
went with that theme by creating a new model called Visitations. User and Projects belong
to the visitations model.

The challenge, for me, was how to handle the last visited date. I wanted to use the simplest
approach possible. I could have added a `last_viewed_at` time field to the table but that
would have meant adding logic to the controller that would set the date to the current time.

There is a feature of Rails that sort of already does that, but, uses the `updated_at`
field. That method is `touch`. Since I wouldn't have to do anything extra, I decided to just
use the `updated_at` field.

I decided to use a `before_action` so that I could ensure I got the last `updated_at`
date to use to display the `notes` that were added after that date. Then, in an `after_action`
I performed the `touch` to update the `updated_at` field.

The great thing about this approach is that I can easily convert this to a polymorphic
association if I need to use this technique on other associations in the future. Score!