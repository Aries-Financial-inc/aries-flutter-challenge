### Project Summary

#### Objective

The project aimed to design and implement a front-end component for both iOS and Android platforms using Flutter, to analyze the risk and reward of options strategies. The component accepts up to four options contracts as input and produces the following outputs:
1. A risk & reward graph with the underlying price at expiry on the X-axis and the profit/loss on the Y-axis.
2. Indicators for max profit, max loss, and break-even points.

#### Implementation

Key aspects:

1. **Completeness of the Logic**:
    - Robust mathematical model to calculate profit and loss for options strategies.
    - `OptionCalculator` class encapsulates core logic.
    - Type-safe data models ensure reliability and maintainability.

2. **Usability of the Graph**:
    - `OptionPayoffChart` component using `syncfusion_flutter_charts` package.
    - Interactive graph dynamically displays risk and reward.
    - Visual markers for max profit, max loss, and break-even points.

3. **Aesthetics of the UI**:
    - Clean, modern design ensures user-friendly experience.
    - Responsive chart adapts to different screen sizes and orientations.

4. **Readability and Code Structure**:
    - Best practices for Flutter development followed.
    - Freezed package used for data modeling.
    - Well-documented code for ease of understanding and contribution.

### Mathematical Model

Handles call and put options, both long and short, calculating profit/loss at different underlying prices:

- **Call Options**:
  - Long Call: `max(0, underlyingPrice - strikePrice) - premium`
  - Short Call: `premium - max(0, underlyingPrice - strikePrice)`

- **Put Options**:
  - Long Put: `max(0, strikePrice - underlyingPrice) - premium`
  - Short Put: `premium - max(0, strikePrice - underlyingPrice)`

### Reusable Graph Component

The `OptionPayoffChart` component is highly reusable and can be integrated into any Flutter project. It takes the following inputs:
- A list of `ProfitLossData` representing the calculated profit/loss at different underlying prices.
- The max profit, max loss, and break-even points to display on the chart.



### Integration with Current Stack
The implementation can be seamlessly integrated with popular state management solutions like Bloc, Riverpod, and Mobx, making it versatile and adaptable to existing codebases.

### Demonstration

To see the project in action, please refer to the attached demonstration:

<img src="/assets/demo.gif?raw=true" width="180">

Looking forward to your feedback and hoping this implementation aligns well with your expectations.