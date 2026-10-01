# google-analytics-action

[![GitHub Release](https://img.shields.io/github/v/release/remarkablemark/google-analytics-action)](https://github.com/remarkablemark/google-analytics-action/releases)
[![test](https://github.com/remarkablemark/google-analytics-action/actions/workflows/test.yml/badge.svg)](https://github.com/remarkablemark/google-analytics-action/actions/workflows/test.yml)
[![lint](https://github.com/remarkablemark/google-analytics-action/actions/workflows/lint.yml/badge.svg)](https://github.com/remarkablemark/google-analytics-action/actions/workflows/lint.yml)

📊 Inject Google Analytics tracking code into an HTML file with GitHub Actions.

## Usage

```yaml
on: push
jobs:
  google-analytics-action:
    runs-on: ubuntu-latest
    steps:
      - name: Google Analytics Action
        uses: remarkablemark/google-analytics-action@v1
        with:
          html-path: dist/index.html
          measurement-id: G-XXXXXXXXXX
```

See [action.yml](action.yml)

## Inputs

### `html-path`

**Required**: The HTML file to modify:

```yaml
- uses: remarkablemark/google-analytics-action@v1
  with:
    html-path: dist/index.html
```

### `measurement-id`

**Required**: The Google Analytics ID (e.g., G-XXXXXXXXXX):

```yaml
- uses: remarkablemark/google-analytics-action@v1
  with:
    measurement-id: G-XXXXXXXXXX
```

## License

[MIT](LICENSE)
