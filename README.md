# DualAD: Dual-Layer Planning for Autonomous Driving
 
<div align='center'>

![DualAD Framework](./assets/teaser.png)

🌍 [Project Page](https://dualad.github.io/) • 🤓 [Paper](https://arxiv.org/pdf/2409.18053) 

</div>

[**TL;DR**] DualAD is an autonomous driving framework that integrates reasoning capabilities (large language models) with traditional planning modules (rule-based) to handle complex driving scenarios. 

The following implementation is based on [nuplan-devkit](https://github.com/motional/nuplan-devkit).

## Installation
- Download the nuPlan dataset as described [HERE](https://nuplan-devkit.readthedocs.io/en/latest/dataset_setup.html). The download link is [here](https://www.nuscenes.org/nuplan#download) (You need to sign up first) and you just need to download the ```Mini Split``` in our case. Make sure you have a general filesystem hierarchy like this (nuplan is at the same level as DualAD's working directory):
   ```bash
   # echo ${HOME} to see what is it
   ${HOME}/nuplan
   ├── exp
   └── dataset
      ├── maps
      └── nuplan-v1.1
   ${HOME}/DualAD
   ```
- Quick install to try DualAD using [miniconda](https://docs.anaconda.com/free/miniconda/miniconda-install/) (This will take some time):
   ```bash
   git clone https://github.com/TUM-AVS/DualAD.git
   cd DualAD
   conda create -n dualad python=3.9
   conda activate dualad
   pip install -e .
   pip install -r requirements.txt
   ```

- Set the environment variable (using ```set_env.sh``` we only set ```NUPLAN_MAPS_ROOT``` etc. temporarily, but if you want to set it permanently, check [SET ENV](./doc/ENV.md))
   ```bash
   . set_env.sh
   ```
## Get LLM API (You can skip this to first run the code without LLM)
[GLM-4-Flash](https://bigmodel.cn/usercenter/apikeys) ([FREE](https://open.bigmodel.cn/pricing)) and [GPT-4o](https://platform.openai.com/settings/organization/api-keys) ([Need to pay](https://openai.com/api/pricing/)). For example, the API keys look like below (if you have problem with getting the free one (GLM-4-Flash), feel free to contact dingrui.wang@tum.de)

   ```bash
   # GLM-4-Flash
   7e8138a27b2cd87c7691ac4a7XXXXXXXXXXXXXXXXXXXXXX
   # GPT-4o
   sk-proj-IDX3WOWAk28xifvCyXXXXXXXXXXXXXXXXXXXXXX
   ```
In [```LLM.yml```](./LLM.yml), add your API keys and set ```use_llm``` to ```True```. If you are using GPT-4o, then set ```use_open_ai``` to ```True```.
## Try DualAD
For DualAD (Lattice-IDM):
   ```bash
   python ./nuplan/planning/script/run_simulation.py
   ```
The planning result can be find in folder below:
   ```bash
   ${HOME}/nuplan
   └── exp
   ```
## Visualization
To visualize the planning results, we use Nuboard, provided by the NuPlan devkit:
   ```bash
   python ./nuplan/planning/script/run_nuboard.py
   ```
This will open a web interface in your default web browser. 
1. In the left panel, click **Upload file**.
2. Select the planning result file ending with `.nuboard` (located in `{HOME}/nuplan/exp`). You may need to navigate through the folders to locate it—e.g., `nuboard_128930XX.nuboard`—and upload it.
3. Next, click the **Scenario** option in the left panel.
4. Click the "gear" icon in the upper-right corner, select a **Scenario Token**, and click **Query Scenario**.

You should now see a view similar to the following:

![Visualization Example](./assets/bokeh_plot.png)

## Results

### Hard-55 benchmark

| Planner                                 | Hard-55 R-CLS | Super-Hard-24 R-CLS |
|-----------------------------------------|---------------|---------------------|
| Log-replay (Expert)                     | 58.32         |   48.70             |
| IDM                                     | 34.56         |   20.73             |
| Lattice-IDM                             | 39.76         |   33.83             |
| PDM-Closed (Rule-based SOTA)            | 35.15         |   7.57              |
| PlanTF (Learning-based SOTA)            | 53,60         | **51.30**           |
| **DualAD (Lattice-IDM + GLM-Flash-4)**  | **57.31**     |   46.03             |


### Highlight
Using a relatively weak LLM (GLM-Flash-4), the integrated model achieves performance comparable to that of a human expert.

| Planner                                 | Hard-55 R-CLS | Super-Hard-24 R-CLS |
|-----------------------------------------|---------------|---------------------|
| Log-replay (Expert)                     | 58.32         |   48.70             |
| Lattice-IDM                             | 39.76         |   33.83             |
| **DualAD (Lattice-IDM + GLM-Flash-4)**  | 57.31         |   46.03             |

## Citation

```text
@article{wang2024dualad,
  title={DualAD: Dual-Layer Planning for Reasoning in Autonomous Driving},
  author={Wang, Dingrui and Kaufeld, Marc and Betz, Johannes},
  journal={arXiv preprint arXiv:2409.18053},
  year={2024}
}
```


## Credits

- [https://github.com/motional/nuplan-devkit](https://github.com/motional/nuplan-devkit)
- [https://github.com/huggingface/huggingface_hub](https://github.com/huggingface/huggingface_hub)
- [https://github.com/MCZhi/GameFormer-Planner](https://github.com/MCZhi/GameFormer-Planner)
- [https://github.com/autonomousvision/tuplan_garage](https://github.com/autonomousvision/tuplan_garage)
- [https://github.com/jchengai/planTF](https://github.com/jchengai/planTF)