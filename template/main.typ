#import "@local/uva-report-unofficial:0.1.0": uva-report

#let abstract = [#lorem(200)]
#show: uva-report.with(
  abstract: abstract,
  title: "My report",
  subtitle: "A great report",
  student_name: "My name",
  student_id: "3141592653",
  lecturer: "My lecturer's name",
  course_name: "Course name",
  course_code: "Course code",
  programme: "My programme",
  academic_year: "2024 - 2025",
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
