/*The titlepage template is heavily inspired by the 'Red Agora' title page template: 
https://github.com/essmehdi/ensias-report-template/ */
#let maybe_email_footnote(author) = {
  if "email" in author {
    footnote(author.email)
  }
}

#let titlepage(
  title: "", 
  subtitle: none, 
  authors: (),
  lecturer: "",
  course_name: "",
  course_code: "",
  programme: none,
  academic_year: none,
  school_logo: "resources/uva_logo_nl.svg",
  title_figure: none,
) = {
  set line(length: 100%, stroke: 0.5pt)
  set table(stroke: none)

  // Display university logo
  block(
    height: 20%, width: 100%, 
    align(center + horizon)[#image(school_logo, width: 70%)]
  )

  // Title
  align(center)[
    #if subtitle != none {
      text(16pt, tracking: 2pt)[#smallcaps[#subtitle]]
    }
    #line()
    #if title != none {
      text(22pt, weight: "bold")[#title]
    }
    #line()
    #text(16pt)[#smallcaps[
      #datetime.today().display("[day] [month repr:long] [year]")
    ]]
  ]

  // Student, lecturer, course details
  h(1fr)
  grid(
    columns: (1fr, 1fr),
    grid.cell(align: left)[
      // Students
      #table(
        columns: (auto, auto),
        [*Student*], [*ID*],
        ..authors.map(author => (
          [#author.name #maybe_email_footnote(author)], 
          author.id
        )).flatten()
      )
    ],
    grid.cell(align: right)[
      // Lecturer
      #table(
        align: right,
        [*Lecturer*],
        lecturer
      )
      // Course
      #table(
        align: right,
        [*Course*],
        course_name,
        course_code,
      )
    ]
  )

  if title_figure != none {
    align(center + horizon, block(
        figure(image(title_figure, width: 35%), numbering: none)
    ))
  }

  // Programme, academic year
  if (programme != none and academic_year != none) {
    align(center + bottom)[
      #programme \
      #text[Academic year: #academic_year]
    ]
  }
}


#let uva-report(
  body,
  abstract: "",
  title: "",
  subtitle: none,
  authors: (),
  lecturer: "",
  course_name: "",
  course_code: "",
  programme: none,
  academic_year: none,
  n_columns: 1,
  bibliography_path: none,
  bibliography_style: "american-psychological-association",
  school_logo: "resources/uva_logo_nl.svg",
  title_figure: none,
  font: "Georgia",
  fontsize: 12pt,
  compact: false,
) = {
  // default to compact if n_columns != 1
  if n_columns != 1 {
    compact = true
  }

  // Set document properties 
  set document(author: authors.map(elem => elem.name), title: title)

  // Display title page first with separate formatting
  titlepage(
    title: title,
    subtitle: subtitle,
    authors: authors,
    lecturer: lecturer,
    course_name: course_name,
    course_code: course_code,
    programme: programme,
    academic_year: academic_year,
    school_logo: school_logo,
    title_figure: title_figure,
  )

  let logo = image(school_logo, width: 60%)
  let header_title = {
    if subtitle != none {
      subtitle
    } else {
      title
    }
  }

  // Page setup
  set page(
    header: grid(
      columns: (auto, 1fr, auto),
      align: (left, center, right + top),
      box[#logo],
      h(1fr),
      text(size: 11pt, weight: 100)[#header_title]
    ),
    columns: n_columns,
    numbering: "1",
  )
  set heading(numbering: "1.")
  set par(justify: true)
  set text(font: font, size: fontsize)
  set figure(placement: auto)
  set math.equation(numbering: "(1)")

  // Make image caption font size small
  show figure.where(kind: image): it => {
    set text(size: 9pt)
    it
  }

  // Ensure level-1 headings start on a new page
  show heading.where(level: 1): it => {
    if not compact {
      pagebreak()
    }
    it
  }
  
  // Contents page: bold main sections, show level 2 indented
  set outline(depth: 2, indent: auto)
  show outline.entry.where(
    level: 1
  ): it => {
    v(12pt, weak: true)
    strong(it)
  }

  // Reset page counter to 1 
  if not compact {
    counter(page).update(1)
  }

  // Show on separate page if not compact
  if not compact {
    set par(justify: false)
    heading(outlined: false, numbering: none)[Abstract]
  } else {
    [= Abstract]
  }
  abstract
  
  // Show table of contents if not compact
  if not compact {
    outline(depth: 2, indent: auto)
  }
  
  body

  if bibliography_path != none {
    set text(size: 9pt)
    bibliography(bibliography_path, style: bibliography_style)
  }
}
