# UTA8: Statistical Analysis Results

<img src="https://github.com/mida-project/meta/blob/master/banners/statistical-analysis.png?raw=true" width="100%" />


[![License](https://img.shields.io/badge/License-Academic%20%2B%20Commercial-blue?style=flat-square)](https://github.com/mida-project/sa-uta8-utaut/blob/master/LICENSE.md)
[![Last commit](https://img.shields.io/github/last-commit/mida-project/sa-uta8-utaut?style=flat-square)](https://github.com/mida-project/sa-uta8-utaut/commits/master)
[![OpenCollective](https://opencollective.com/oppr/backers/badge.svg?style=flat-square)](#backers)
[![OpenCollective](https://opencollective.com/oppr/sponsors/badge.svg?style=flat-square)](#sponsors)
[![Gitter](https://img.shields.io/gitter/room/gitterHQ/gitter.svg?style=flat-square)](https://gitter.im/opprTeam)
[![Twitter](https://flat.badgen.net/badge/icon/twitter?icon=twitter&label)](https://twitter.com/opprGroup)

Welcome to the GitHub repository for our paper "[Modeling Adoption of Intelligent Agents in Medical Imaging](https://doi.org/10.1016/j.ijhcs.2022.102922)" ([doi.org/10.1016/j.ijhcs.2022.102922](https://doi.org/10.1016/j.ijhcs.2022.102922)) publised in the top tear (Q1 in 2022) [International Journal of Human-Computer Studies (IJHCS)](https://www.sciencedirect.com/journal/international-journal-of-human-computer-studies) of [Elsevier](https://www.elsevier.com/)! This paper investigates the factors affecting the acceptance of Artificial Intelligence (AI) in medical imaging using a model based on the [Unified Theory of Acceptance and Use of Technology (UTAUT)](https://en.wikipedia.org/wiki/Unified_theory_of_acceptance_and_use_of_technology). Our study includes an international evaluation of healthcare practitioners and provides valuable theoretical contributions to researchers by explaining the reasons behind the adoption and usage of intelligent agents in the medical imaging workflow. We hope that our research will inform and inspire future studies in this exciting and rapidly developing field. To organize our user evaluations, we devide each study in a group of User Tests and Analysis (UTA) to guide us during these studies. As follows, some details are provided for more information about these guides.

In this repository, we present our data and results of the [UTA8](https://github.com/MIMBCD-UI/meta/wiki/User-Research#user-test-evaluations-) ([10.13140/RG.2.2.22948.40322](http://dx.doi.org/10.13140/RG.2.2.22948.40322)) guide. These *results* are representing the pieces of information of both [BreastScreening](https://BreastScreening.github.io), [MIDA](https://mida-project.github.io), and [MIMBCD-UI](https://mimbcd-ui.github.io/) projects. These projects are research projects that deal with the use of a recently proposed technique in literature: [Deep Convolutional Neural Networks (CNNs)](https://en.wikipedia.org/wiki/Convolutional_neural_network). From a developed User Interface (UI) and *framework*, these deep networks will incorporate [several datasets](https://github.com/MIMBCD-UI/meta/wiki/Datasets) in different modes. You can find the [deployed prototypes](https://github.com/MIMBCD-UI/meta-private/blob/master/wiki/Technical.md#deployment-prototypes) on the [`Technical.md`](https://github.com/MIMBCD-UI/meta-private/blob/master/wiki/Technical.md#deployment-prototypes) file of the [`meta-private`](https://github.com/MIMBCD-UI/meta-private) repository. More information about the study is also available on the [`User-Research.md`](https://github.com/MIMBCD-UI/meta-private/blob/master/wiki/User-Research.md#test-11-assertive-and-non-assertive-introduction-) file of this [`meta-private`](https://github.com/MIMBCD-UI/meta-private) repository. Unfortunately, you need to be a member of our team to access the restricted information. We also have several demos to see in our [YouTube Channel](https://www.youtube.com/channel/UCPz4aTIVHekHXTxHTUOLmXw), please follow us.

## Citing

We kindly ask **scientific works and studies** that make use of the repository to cite it in their associated publications. Similarly, we ask **open-source** and **closed-source** works that make use of the repository to warn us about this use.

You can cite our work using the following BibTeX entry:

```
@article{CALISTO2022102922,
title = {Modeling Adoption of Intelligent Agents in Medical Imaging},
journal = {International Journal of Human-Computer Studies},
volume = {168},
pages = {102922},
year = {2022},
issn = {1071-5819},
doi = {https://doi.org/10.1016/j.ijhcs.2022.102922},
url = {https://www.sciencedirect.com/science/article/pii/S1071581922001422},
author = {Francisco Maria Calisto and Nuno Nunes and Jacinto C. Nascimento},
keywords = {Unified Theory of Acceptance and Use of Technology, Human-Computer Interaction, Artificial Intelligence, Healthcare, Medical Imaging},
abstract = {Artificial intelligence has the potential to transform many application domains fundamentally. One notable example is clinical radiology. A growing number of decision-making support systems are available for lesion detection and segmentation, two fundamental steps to accomplish diagnosis and treatment planning. This paper proposes a model based on the unified theory of acceptance and use of technology to study the determinants for the adoption of intelligent agents across the medical imaging workflow. We tested the model via confirmatory factor analysis and structural equation modeling using clinicians’ data from an international evaluation of healthcare practitioners. Results show an increased understanding of the vital role of security, risk, and trust in the usage intention of intelligent agents. These empirical findings provide valuable theoretical contributions to researchers by explaining the reasons behind the adoption and usage of intelligent agents in the medical imaging workflow.}
}
```

## Table of contents

* [Prerequisites](#Prerequisites)
* [Usage](#Usage)
* [Roadmap](#Roadmap)
* [Contributing](#Contributing)
* [License & Copyright](#License--Copyright)
* [Team](#Team)
* [Acknowledgements](#Acknowledgements)

## Prerequisites

The following list is showing the required dependencies for this project to run locally:

* [Git](https://git-scm.com/) or any other Git or GitHub version control tool
* [R](https://www.r-project.org/) (v4.3.0 or newer)
* [Rscript](https://stat.ethz.ch/R-manual/R-devel/library/utils/html/Rscript.html)
* [`lavaan`](https://lavaan.ugent.be/)
* [`ggplot2`](https://ggplot2.tidyverse.org/)

Here are some tutorials and documentation, if needed, to feel more comfortable about using and playing around with this repository:

* [Git Tutorial](https://git-scm.com/docs/gittutorial)
* [GitHub Quick Tutorial](https://guides.github.com/activities/hello-world/)
* [R Tutorial](https://www.w3schools.com/r/)
* [CFA in R with `lavaan`](https://stats.idre.ucla.edu/r/seminars/rcfa/)
* [Guide for CFA and SEM with `lavaan`](https://methodenlehre.github.io/SGSCLM-R-course/cfa-and-sem-with-lavaan.html)

## Usage

Usage follow the instructions here to setup the current repository and extract the present data. To understand how the hereby repository is used for, read the following steps.

### Installation

At this point, the only way to install this repository is manual. Eventually, this will be accessible through the [RStudio](https://posit.co/download/rstudio-desktop/), as mentioned on the [roadmap](#Roadmap).

Nonetheless, this kind of installation is as simple as cloning this repository. Virtually all Git and GitHub version control tools are capable of doing that. Through the console, we can use the command below, but other ways are also fine.

```bash
git clone https://github.com/mida-project/sa-uta8-utaut.git
```

### Demonstration

Please, feel free to try out our radiomics version of the anslysis. It is a source called `Radiomics_changed.r` at the `src/` directory. It can be used as follows:

```bash
Rscript src/Radiomics_changed.r
```

Just keep in mind this is just a script for statistical analysis purposes, so it does nothing more than analyzing data from a radiomics study using various packages in the R language. The script loads libraries that enable it to perform operations on the data, such as read and plot data, perform [Principal Component Analysis (PCA)](https://en.wikipedia.org/wiki/Principal_component_analysis), and conduct a [Confirmatory Factor Analysis (CFA)](https://en.wikipedia.org/wiki/Confirmatory_factor_analysis) to identify latent variables and their interrelations. Also, we did our best to make the statistical analysis as user-friendly as possible, so, above everything else, have fun! 😁

The first part of the code loads data from an Excel file, converts the data into a likert dataset, and plots it. Then it checks the data, calculates and visualizes the correlation matrix, and performs PCA to obtain principal components.

The code then determines the number of factors to extract from the data and performs maximum likelihood factor analysis, which is followed by visualizing the results using the [`ggplot2`](https://ggplot2.tidyverse.org/) library. The script then loads another dataset and performs a CFA, followed by computing reliability, discriminant validity, and fit measures of the model. Finally, it extracts the standardized loading matrix, calculates mean squared loadings (*i.e.*, [AVEs](https://en.wikipedia.org/wiki/Average_variance_extracted)), and calculates the power analysis using `miPowerFit` method.

## Roadmap

[![CII Best Practices](https://bestpractices.coreinfrastructure.org/projects/3819/badge)](https://bestpractices.coreinfrastructure.org/projects/3819)

Our goal for this repository is to investigate factors affecting the acceptance of artificial intelligence in medical imaging. To achieve this goal, we will use the unified theory of acceptance and use of technology as the basis for our model, and test it using clinical data from an international evaluation of healthcare practitioners.

We strive to follow best practices for code development and documentation, and have implemented the [Core Infrastructure Initiative (CII)](https://bestpractices.coreinfrastructure.org/en/projects/3172) specifications to ensure the security and reliability of our codebase.

In the future, we aim to create a configuration file to automate testing and publishing of our code to [CRAN](https://cran.r-project.org/) or any other package manager, and we plan to leverage [GitHub Actions](https://github.com/features/actions)s for this purpose. We may also explore additional goals and objectives as we continue to develop this project.

## Contributing

This project exists thanks to all the people who [contribute](CONTRIBUTING.md). We welcome everyone who wants to help us improve this repository. As follows, we present some suggestions.

### Issuer

Either as something that seems missing or any need for support, just open a [new issue](https://github.com/mida-project/sa-uta8-utaut/issues/new). Regardless of being a simple request or a fully-structured feature, we will do our best to understand them and, eventually, solve them.

### Developer

We like to develop, but we also like collaboration. You could ask us to add some features... Or you could want to do it yourself and fork this repository. Maybe even do some side-project of your own. If the latter ones, please let us share some insights about what we currently have.

## Information

The current information will summarize important items of this repository. In this section, we address all fundamental items that were crucial to the current information.

### Related Repositories

- [`dataset-uta7-demographics`](https://github.com/MIMBCD-UI/dataset-uta7-demographics)

- [`sa-uta7-recall-precision`](https://github.com/mida-project/sa-uta7-recall-precision)

- [`sa-uta8-utaut-backup`](https://github.com/mida-project/sa-uta8-utaut-backup) (Restricted)

- [`dataset-uta11-results`](https://github.com/MIMBCD-UI/dataset-uta11-results)

### Dataset Resources

To publish our [datasets](https://www.kaggle.com/MIMBCD-UI) we used a well known platform called [Kaggle](https://www.kaggle.com). To access our project's [Profile Page](https://www.kaggle.com/MIMBCD-UI) just follow the [link](https://www.kaggle.com/MIMBCD-UI). Here, you will find all of our published datasets and any associated information, such as descriptions and download links.

### License & Copyright

Copyright &copy; 2023 [Instituto Superior Técnico](http://tecnico.ulisboa.pt/)

[![Creative Commons License](https://i.creativecommons.org/l/by-sa/4.0/88x31.png)](http://creativecommons.org/licenses/by-sa/4.0/)

The [`sa-uta8-utaut`](https://github.com/mida-project/sa-uta8-utaut) repository is distributed under the terms of both [Academic License](https://github.com/mida-project/sa-uta8-utaut/blob/main/ACADEMIC.md) for academic purpose and [Commercial License](https://github.com/mida-project/sa-uta8-utaut/blob/main/COMMERCIAL.md) for commercial purpose, as well as under the [CC-BY-SA-4.0](COPYING.md) copyright. The content of the present repository has obtained the patent right of [World Intellectual Property Organization (WIPO)](https://www.wipo.int) invention. Moreover, the hereby invention for this repository is under protection of the patent number **[WO2022071818A1](https://patents.google.com/patent/WO2022071818A1)** with the application number **PCT/PT2021/050029**. The title of the invention is "*Computational Method and System for Improved Identification of Breast Lesions*", registered under the WO patent office.

See [ACADEMIC](https://github.com/mida-project/sa-uta8-utaut/blob/main/ACADEMIC.md) and [COMMERCIAL](https://github.com/mida-project/sa-uta8-utaut/blob/main/COMMERCIAL.md) for details. For more information about the [MIMBCD-UI](https://mimbcd-ui.github.io/) Project just follow the [link](https://github.com/MIMBCD-UI/meta).

### Team

Our team brings everything together sharing ideas and the same purpose, developing even better work. In this section, we will nominate the full list of important people for this repository, as well as respective links.

#### Authors

* Francisco Maria Calisto [ [Academic Website](https://web.tecnico.ulisboa.pt/francisco.calisto) | [ResearchGate](https://www.researchgate.net/profile/Francisco_Maria_Calisto) | [GitHub](https://github.com/FMCalisto) | [Twitter](https://twitter.com/FMCalisto) | [LinkedIn](https://www.linkedin.com/in/fmcalisto/) ]

* Nuno Nunes [ [ResearchGate](https://www.researchgate.net/profile/Nuno_Nunes2) ]

* Jacinto C. Nascimento [ [ResearchGate](https://www.researchgate.net/profile/Jacinto_Nascimento) ]

#### Promoters

* João Fernandes
* Margarida Morais
* Carlos Santiago
* João Maria Abrantes
* Hugo Lencastre
* Nádia Mourão
* Miguel Bastos
* Pedro Diogo
* João Bernardo
* Madalena Pedreira
* Mauro Machado

#### Companions

* Bruno Dias
* Bruno Oliveira
* Luís Ribeiro Gomes
* Pedro Miraldo

#### Acknowledgements

This work was partially supported by national funds through [FCT](http://fct.pt/) and [IST](http://tecnico.ulisboa.pt/) through the [UID/EEA/50009/2013](https://www.fct.pt/apoios/projectos/consulta/vglobal_projecto.phtml.en?idProjecto=147329&idElemConcurso=8999) project, [BL89/2017-IST-ID](http://ist-id.pt/en/) grant. We thank [Dr. Clara Aleluia](https://www.researchgate.net/profile/Clara_Aleluia) and her [radiology team](https://repositorio.hff.min-saude.pt/handle/10400.10/4?locale=en) of [HFF](https://hff.min-saude.pt/) for valuable insights and helping during this research work. We are indebted to those who gave their time and expertise to evaluate our work, who among others are giving us crucial information for the [BreastScreening](https://github.com/BreastScreening) project.

### Supporting

Our organization is a non-profit organization. However, we have many needs across our activity. From infrastructure to service needs, we need some time and contribution, as well as help, to support our team and projects.

<span>
  <a href="https://opencollective.com/oppr" target="_blank">
    <img src="https://opencollective.com/oppr/tiers/backer.svg" width="220">
  </a>
</span>

#### Contributors

This project exists thanks to all the people who contribute. [[Contribute](CONTRIBUTING.md)].

<span class="image">
  <a href="graphs/contributors">
    <img src="https://opencollective.com/oppr/contributors.svg?width=890" />
  </a>
</span>

#### Backers

Thank you to all our backers! 🙏 [[Become a backer](https://opencollective.com/oppr#backer)]

<span>
  <a href="https://opencollective.com/oppr#backers" target="_blank">
    <img src="https://opencollective.com/oppr/backers.svg?width=890">
  </a>
</span>

#### Sponsors

Support this project by becoming a sponsor. Your logo will show up here with a link to your website. [[Become a sponsor](https://opencollective.com/oppr#sponsor)]

<span>
  <a href="https://opencollective.com/oppr/sponsor/0/website" target="_blank">
    <img src="https://opencollective.com/oppr/sponsor/0/avatar.svg">
  </a>
</span>

<br />

<span>
  <a href="http://www.fct.pt/" title="FCT" target="_blank">
    <img src="https://github.com/mida-project/meta/blob/master/brands/fct_footer.png?raw=true" alt="fct" width="20%" />
  </a>
</span>
<span>
  <a href="https://www.fccn.pt/en/" title="FCCN" target="_blank">
    <img src="https://github.com/mida-project/meta/blob/master/brands/fccn_footer.png?raw=true" alt="fccn" width="20%" />
  </a>
</span>
<span>
  <a href="https://www.ulisboa.pt/en/" title="ULisboa" target="_blank">
    <img src="https://github.com/mida-project/meta/blob/master/brands/ulisboa_footer.png?raw=true" alt="ulisboa" width="20%" />
  </a>
</span>
<span>
  <a href="http://tecnico.ulisboa.pt/" title="IST" target="_blank">
    <img src="https://github.com/mida-project/meta/blob/master/brands/ist_footer.png?raw=true" alt="ist" width="20%" />
  </a>
</span>
<span>
  <a href="http://hff.min-saude.pt/" title="HFF" target="_blank">
    <img src="https://github.com/mida-project/meta/blob/master/brands/hff_footer.png?raw=true" alt="hff" width="20%" />
  </a>
</span>
<span>
  <a href="https://www.chtmad.min-saude.pt/" title="CHTMAD" target="_blank">
    <img src="https://raw.githubusercontent.com/MIMBCD-UI/meta/master/brands/chtmad_footer.png" alt="chtmad" width="10%" />
  </a>
</span>

##### Departments

<span>
  <a href="http://dei.tecnico.ulisboa.pt" title="DEI" target="_blank">
    <img src="https://github.com/mida-project/meta/blob/master/brands/dei_footer.png?raw=true" alt="dei" width="20%" />
  </a>
</span>
<span>
  <a href="http://deec.tecnico.ulisboa.pt" title="DEEC" target="_blank">
    <img src="https://github.com/mida-project/meta/blob/master/brands/deec_footer.png?raw=true" alt="dei" width="20%" />
  </a>
</span>

##### Laboratories

<span>
  <a href="http://sipg.isr.tecnico.ulisboa.pt/" title="SIPG" target="_blank">
    <img src="https://github.com/mida-project/meta/blob/master/brands/sipg_footer.png?raw=true" alt="sipg" width="20%" />
  </a>
</span>
<span>
  <a href="http://welcome.isr.tecnico.ulisboa.pt/" title="ISR" target="_blank">
    <img src="https://github.com/mida-project/meta/blob/master/brands/isr-lisboa_footer.png?raw=true" alt="isr" width="20%" />
  </a>
</span>
<span>
  <a href="http://larsys.pt/" title="LARSys" target="_blank">
    <img src="https://github.com/mida-project/meta/blob/master/brands/larsys_footer.png?raw=true" alt="larsys" width="20%" />
  </a>
</span>
<span>
  <a href="https://www.m-iti.org/" title="M-ITI" target="_blank">
    <img src="https://github.com/mida-project/meta/blob/master/brands/iti_footer.png?raw=true" alt="iti" width="20%" />
  </a>
</span>
<span>
  <a href="http://www.inesc-id.pt/" title="INESC-ID" target="_blank">
    <img src="https://github.com/mida-project/meta/blob/master/brands/inesc-id_footer.png?raw=true" alt="inesc-id" width="20%" />
  </a>
</span>

##### Domain

<span>
  <a href="https://europa.eu/" title="EU" target="_blank">
    <img src="https://github.com/mida-project/meta/blob/master/brands/eu_footer.png?raw=true" alt="eu" width="20%" />
  </a>
</span>
<span>
  <a href="https://www.portugal.gov.pt/" title="Portugal" target="_blank">
    <img src="https://github.com/mida-project/meta/blob/master/brands/pt_footer.png?raw=true" alt="pt" width="20%" />
  </a>
</span>
