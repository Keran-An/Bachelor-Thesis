# Bachelor-Thesis: Study on the Impact of Two-way FDI on China's Innovation Capability

## Tables of Content
- [Description](#description)
- [Data Resource](#data-resource)
- [Analysis Steps and Scripts Overview](#analysis-steps-and-scripts-overview)
- [Resutls](#resutls)

### Description
- In the process of deepening Reform and Opening up, China’s development strategy of "Bring in and Go out" has made significant progress, and the scale of utilizing Foreign Direct Investment and Outward Foreign Direct Investment has been increasing, with remarkable achievements in economic development. 
- In order to further enhance its competitive advantage in the world market, China has repeatedly emphasized the strategy of "Scientific and Technological Powerhouse", actively developing high-tech industries and improving its independent R&D capability. As an important channel for China to contact with the world's frontier technology, two-way FDI is always important for the improvement of China's innovation ability. 
- The study of how to improve China's innovation capability through two-way FDI is of strong practical significance to release the technological dividend of two-way FDI and promote China's technological progress.

### Data Resource
- (Raw data not publicly available due to restrictions.)
- The total amount of Inward Foreign Direct Investment (IFDI) for each province (including municipalities and autonomous regions) was obtained from statistical data provided by the Ministry of Commerce of the People's Republic of China.
- Data on outward non-financial direct investment flows was collected from the Statistical Bulletin of China's Outward Foreign Direct Investment. - Provincial patent applications and the number of personnel involved in R&D activities were sourced from the annual editions of the China Statistical Yearbook on Science and Technology.
- Annual average RMB exchange rates, total imports and exports, industrial value-added, regional GDP, and the number of broadband internet subscribers for each province were taken from the China Statistical Yearbook.
- Data on total lengths of highways and railways, as well as provincial land area sizes, were acquired from the official website of the National Bureau of Statistics of China.
- Finally, outstanding loans of financial institutions for each province were sourced from the China Financial Yearbook and the People's Bank of China.

### Analysis Steps and Scripts Overview

| Step | Stata Script              | Description                                        |
|------|---------------------------|----------------------------------------------------|
| 1    | `01_data_preparation.do`  | Data cleaning, logarithmic transformation, and panel data setup |
| 2    | `02_descriptive_analysis.do`| Descriptive statistics, correlation, multicollinearity checks, and winsorization |
| 3    | `03_model_selection.do`   | Hausman test with bootstrap robustness checks      |
| 4    | `04_regression_analysis.do`| Main regression and subgroup regression analyses  |
| 5    | `05_mediation_analysis.do`| Mediation effect analysis                          |

### Resutls
- The research results show that two-way FDI has a positive effect on innovation capability, among which FDI has a more obvious role in promoting China's innovation capability. Meanwhile, the developments of two-way FDI in the east, middle and west regions of China differ significantly, among which the eastern region, as the main undertaking and origin of two-way FDI, is also in the leading position in terms of innovation level.
- The results of the intermediary effect model show that the human capital enhancement effect is one of the important channels for two-way FDI to play a role in promoting innovation capability.
- Taking into account the current economic background, this paper proposes to strengthen policy support, encourage enterprises to be globalization, pay attention to the quality of FDI, and attract high-level capital inflows. Each region should also develop two-way FDI according to local conditions, pay attention to talent cultivation, strengthen the construction of intellectual property rights system, and enhance their competitiveness.
- The findings of the article may provide insights for advancing China's goal of forming a new era of opening up to the outside world and achieving a strong science and technology nation.

