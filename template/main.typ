#import "@local/gliding-uva-report:0.1.0": report, paper

#let abstract = [#lorem(100)]
#let authors = (
  (name: "My name", id: "MyID"), 
  (name: "Your name", id: "YourID", email: "you@youremail.com")
)
#let course = (
  name: "Course name", 
  code: "Course code", 
  lecturer: "My lecturer's name"
)
#show: paper.with(
  abstract: abstract,
  title: "My report",
  subtitle: "A great report",
  authors: authors,
  course: course,
)

= Introduction
#lorem(100)

#lorem(200)

#lorem(150)

= Methods
#lorem(100)

#lorem(150)

#lorem(130)

= Discussion
#lorem(200)

#lorem(300)

#lorem(200)

= Conclusion
#lorem(250)
