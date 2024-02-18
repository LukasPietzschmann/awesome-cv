\RequirePackage{etoolbox}
\appto\input@path{{smile}}

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{awesomecv}[]

\LoadClass[11pt]{article}

\RequirePackage[
	hmargin=3cm,
	vmargin=2cm
]{geometry}
\RequirePackage{microtype}
\RequirePackage{parskip}
\RequirePackage{setspace}
\RequirePackage[sfdefault]{josefin}
\RequirePackage{fontawesome5}
\RequirePackage{xurl}
\RequirePackage[hidelinks]{hyperref}
\RequirePackage[
	tikz,
]{smile}

\newcommand\cv@infocard[2][]{\begin{tikzpicture}[node distance=1ex]
	\node (T) {#2};
	\if\relax\detokenize{#1}\relax
		\coordinate (S) at (T);
	\else
		\node[roundnode,draw=none,fill=accent!2,left=of T] (S) {\color{accent}#1};
	\fi
	\node[roundednode,minimum height=2.2\ht\strutbox,draw=none,fill=accent!10,fit=(S)(T),node on layer=background] {};
\end{tikzpicture}}

\newenvironment{infos}{
	\newcommand\info[2][]{\cv@infocard[##1]{##2}}
	\def\tel##1{\info[\faPhone]{##1}}
	\def\mail##1{\info[\faEnvelope]{\href{mailto:##1}{##1}}}
	\def\github##1{\info[\faGithub]{\href{https://github.com/##1}{##1}}}
	\def\linkedin##1{\info[\faLinkedin]{\href{https://www.linkedin.com/in/##1}{##1}}}
	\def\address##1{\info[\faMapMarker*]{##1}}
	\def\website##1{\info[\faGlobe]{##1}}
	\doublespacing
}{}

\newenvironment{skills}{
	\section*{Skills}
	\def\skill##1{\cv@infocard{##1}}
}{}

\newenvironment{education}{
	\section*{Education}
	\def\entry##1##2##3##4{
		\subsection*{##1\hfill\normalsize\normalfont\textcolor{gray}{##3}}
		\textcolor{accent}{##2}\\
		##4
	}
}{}

\newenvironment{experience}{
	\section*{Experience}
	\newenvironment{entry}[3]{% Was, wo, wann
		\subsection*{##1\hfill\normalsize\normalfont\textcolor{gray}{##3}}
		\textcolor{accent}{##2}\par
		\itemize
	}{\enditemize}
}{}

\newenvironment{publications}{
	\section*{Publications}
	\def\entry##1{\fullcite{##1}}
}{}

\def\pic#1{\def\@pic{#1}\def\@picwidth{2.5cm}}
\def\picwidth#1{\def\@picwidth{#1}}

\def\maketitle{\begingroup
	\Huge\bfseries\@author\hfill\ifdefined\@pic\begin{tikzpicture}
		\begin{scope}
			\clip[rnd] (0,0) rectangle coordinate (centerpoint) ++ (\@picwidth,\@picwidth); \node[inner sep=\z@,outer sep=\z@] at (centerpoint) {\includegraphics[width=\@picwidth]{\@pic}};
		\end{scope}
	\end{tikzpicture}\fi\break%
\endgroup}
