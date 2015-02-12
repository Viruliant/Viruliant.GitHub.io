#!/bin/bash

sudo find ./ -name "*" -exec sudo chmod 664 {} \;
sudo find ./ -type d -exec sudo chmod 775 {} \;

sudo find ./ -name "*.sh" -exec sudo chmod 775 {} \;
sudo find ./ -name "*.py" -exec sudo chmod 775 {} \;
sudo find ./ -name "*.ss" -exec sudo chmod 775 {} \;
sudo find ./ -name "*.scm" -exec sudo chmod 775 {} \;

