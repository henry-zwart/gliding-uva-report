/*The titlepage template is heavily inspired by the 'Red Agora' title page template: 
https://github.com/essmehdi/ensias-report-template/ */
#let maybe_email_footnote(author) = {
  if "email" in author {
    footnote(author.email)
  }
}

#let title-page(
  title: "",
  subtitle: none,
  authors: (),
  course: none,
  programme: none,
  academic_year: none,
  school_logo: none,
  title_figure: none,
) = {
  set line(length: 100%, stroke: 0.5pt)
  set table(stroke: none)
  set text(font: "Libertinus Serif")

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

  grid(
    columns: (1fr, 1fr),
    grid.cell(align: left, table(
        columns: (auto, auto),
        [*Student*], [*ID*],
        ..authors.map(author => (
          [#author.name #maybe_email_footnote(author)], 
          author.id
        )).flatten()
      )
    ),
    grid.cell(align: right)[
      // Lecturer
      #table(
        align: right,
        [*Lecturer*],
        course.lecturer
      )
      // Course
      #table(
        align: right,
        [*Course*],
        course.name,
        course.code,
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

#let title-section(
  title: "",
  subtitle: none,
  authors: (),
  course: none,
  school_logo: none,
) = {
  set line(length: 100%, stroke: 0.5pt)
  set table(stroke: none)
  set text(font: "Libertinus Serif")

  place(
    top,
    float: true,
    scope: "parent",
    clearance: 30pt,
    {
      align(center, {
        text(16pt, tracking: 2pt, smallcaps(subtitle))
        linebreak()
        text(22pt, weight: "bold", title)
        line()
        text(14pt, smallcaps(
          datetime.today().display("[day] [month repr:long] [year]")
        ))
      })

      // Display the authors list.
      set par(leading: 0.6em)
      for i in range(calc.ceil(authors.len() / 3)) {
        let end = calc.min((i + 1) * 3, authors.len())
        let is-last = authors.len() == end
        let slice = authors.slice(i * 3, end)
        grid(
          columns: slice.len() * (1fr,),
          gutter: 12pt,
          ..slice.map(author => align(center, {
            text(size: 11pt, author.name)
            if "id" in author [
              \ #emph(author.id)
            ]
            if "email" in author {
              if type(author.email) == str [
                \ #link("mailto:" + author.email)
              ] else [
                \ #author.email
              ]
            }
          }))
        )

        if not is-last {
          v(16pt, weak: true)
        }
      }
    })
}


#let paper(
  abstract: "",
  title: "Paper title",
  subtitle: none,
  authors: (),
  course: none,
  programme: none,
  academic_year: none,
  n_columns: 2,
  paper-size: "us-letter",
  school_logo: "resources/uva_logo_nl.svg",
  font: "Georgia",
  fontsize: 10pt,
  titlepage: false,
  title_figure: none,
  bibliography: none,
  bib_style: "american-psychological-association",
  bib_fontsize: 9pt,
  body,
) = {
  set document(author: authors.map(elem => elem.name), title: title)

  // Page setup
  set page(
    paper: paper-size,
    numbering: "1",
    columns: 2,
    header: {
      let header_img = box(image(school_logo, width: 60%))
      let header_title = text(
        size: 11pt, 
        weight: 100, 
        font: "Libertinus Serif", 
        if subtitle != none [#subtitle] else [#title]
      )
      grid(
        columns: (auto, 1fr, auto),
        align: (left, center, right + top),
        header_img, h(1fr), header_title
      )
    }
  )
  set par(justify: true)

  // Body text
  set text(font: font, size: fontsize)

  // Figures
  set figure(placement: auto)
  show figure.where(kind: image): it => {
    set text(size: 9pt)
    it
  }

  set heading(numbering: "1.")
  set math.equation(numbering: "(1)")

  show std.bibliography: set text(bib_fontsize)
  set std.bibliography(title: text(10pt)[References], style: bib_style)

  // Show title
  if titlepage == true {
    set page(columns: 1, header: none)
    title-page(
      title: title, 
      subtitle: subtitle, 
      authors: authors, 
      course: course, 
      programme: programme, 
      academic_year: academic_year, 
      school_logo: school_logo, 
      title_figure: title_figure,
    )
  } else {
    place(
      top, float: true, scope: "parent", clearance: 0em,
      title-section(
        title: title, 
        subtitle: subtitle, 
        authors: authors, 
        course: course, 
        school_logo: school_logo, 
    ))
  }

  if abstract != none {
    set heading(outlined: false, numbering: none)
    [= Abstract]
    abstract
  }

  body

  bibliography
}


#let report(
  abstract: "",
  title: "",
  subtitle: none,
  authors: (),
  course: none,
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
  include_outline: true,
  body,
) = {
  // Set document properties 
  set document(author: authors.map(elem => elem.name), title: title)

  // Display title page first with separate formatting
  title-page(
    title: title,
    subtitle: subtitle,
    authors: authors,
    course: course,
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
    numbering: none,
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

  // Show on separate page if not compact
  {
    set par(justify: false)
    set heading(outlined: false, numbering: none)
    [= Abstract]
    abstract
    if compact {
      pagebreak()
    }
  }  
  
  if include_outline {
    outline(depth: 2, indent: auto)
    if compact {
      pagebreak() 
    }
  }

  // Reset page counter to 1 
  set page(numbering: "1")
  counter(page).update(1)
  
  body

  if bibliography_path != none {
    set text(size: 9pt)
    bibliography(bibliography_path, style: bibliography_style)
  }
}
