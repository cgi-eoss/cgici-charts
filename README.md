# CGI Space Helm Charts

This repository is a collection of [Helm](https://helm.sh/) Charts for shared
use in CGI Space Kubernetes environments.

## Usage

To package the Charts and generate repository metadata, use the `build_repo.sh`
script. This will generate a Helm repository in the `docs` directory, which is
exposed via GitHub Pages (ref: [Helm docs](https://docs.helm.sh/developing_charts/#github-pages-example)).
Soon after the master branch is updated, the [Helm repo](https://cgi-eoss.github.io/cgici-charts/)
will reflect the changes.

When adding a new Chart, prefer in this order:
* Importing an existing Chart without modifications (e.g. from the [official repo](https://github.com/kubernetes/charts/))
* Adapting or modifying an existing Chart
* Importing and templating a set of existing Kubernetes manifests
* Creating a Chart from scratch

General packaging best practices should be followed:
* Provide comments/docs to guide users
* Bump Chart `version` and `appVersion` numbers appropriately when updating
* Avoid hard-coding values, in favour of the standard Helm `Values` and
  template functionality

After adding a new Chart, update the [CHARTS.md](CHARTS.md) file with
provenance and notes, and add it to the `PACKAGES` variable in `build_repo.sh`.

Remember to re-run `build_repo.sh` after adding or modifying any Chart.

### Custom container images

If no appropriate container image exists in a public registry, provide an
`images` directory in the Chart, containing the source required to build the
necessary images. Build and deployment actions should be set up for all such
images before the Chart can be used in a cluster.

## Future work / in-progress

* CI integration to build and publish Helm repo without GitHub Pages
