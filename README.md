# An analysis of Aerial Bombing Target Prioritization Against Germany of WWII

## Overview

The strategic targeting of military assets during World War II was crucial for the success of aerial bombing campaigns. Prioritizing targets effectively could have significant implications on the war’s outcome. This study focuses on the aerial bombing campaigns against Germany, aiming to understand the factors influencing the prioritization of targets from an operational perspective.

We used a Bayesian ordered logistic regression model to analyze and the data is obtained from [Data World](https://data.world/datamil/world-war-ii-thor-data).


## File Structure

The repo is structured as:

-   `data/raw_data` contains the raw data as obtained from [Data World](https://data.world/datamil/world-war-ii-thor-data).
-   `data/analysis_data` contains the cleaned dataset that was constructed.
-   `model` contains fitted models. 
-   `other` contains relevant literature, details about LLM chat interactions, and sketches.
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper and datasheet. 
-   `scripts` contains the R scripts used to simulate, download, clean and model data.


## Statement on LLM usage

Aspects of the paper and code were written with the help of ChatGPT and the entire chat history is available in other/llm/usage.txt.
