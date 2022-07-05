import 'dart:math' as math;

import 'constants.dart';

enum DefineAction {
  none,
  threeSides,
  threeAnglesAndASide,
  twoSidesAndCornerBetween,
  twoSidesAndCorner,
  twoCornersAndASide,
}

class TriangleModel {
  double alpha;
  double betta;
  double gamma;
  double sideA;
  double sideB;
  double sideC;

  //DrawData
  double? bottomSide;
  double? leftSide;
  double? rightSide;
  double? leftCorner;
  double? rightCorner;
  double? topCorner;

  //right triangle
  bool rightTriangle = false;

  double? get largestSide {
    List<double> values = [sideA, sideB, sideC];
    values.sort();
    return values.last;
  }

  double get hTopToBottom {
    return (leftSide! * math.sin(leftCorner!.radians));
  }

  double get leftOfH {
    return math.sqrt(math.pow(leftSide!, 2) - math.pow(hTopToBottom, 2));
  }

  double get rightOfH {
    return math.sqrt(math.pow(rightSide!, 2) - math.pow(hTopToBottom, 2));
  }

  DefineAction action = DefineAction.none;
  bool isValid = false;
  String message = '';

  TriangleModel(
      {this.alpha = 0,
      this.betta = 0,
      this.gamma = 0,
      this.sideA = 0,
      this.sideB = 0,
      this.sideC = 0});

  void resetTriangle() {
    alpha = 90;
    betta = 0;
    gamma = 0;
    sideA = 0;
    sideB = 0;
    sideC = 0;
    bottomSide = 0;
    leftSide = 0;
    rightSide = 0;
    leftCorner = 0;
    rightCorner = 0;
    topCorner = 0;
    isValid = false;
    action = DefineAction.none;
    message = '';
    rightTriangle = false;
  }

  double convertDegreeToRadian(double degree) {
    return degree * PI / 180;
  }

  double convertRadianToDegree(double radian) {
    return radian * 180 / PI;
  }

  void fillDrawData(TriangleModel triangle) {
    if (alpha == 90) {
      // rtHypotenuse = sideA;
      //
      // rtBase = sideB;
      // rtHeight = sideC;

      if (sideB >= sideC) {
        bottomSide = sideB;

        leftSide = sideC;
        rightSide = sideA;
        leftCorner = alpha;
        rightCorner = gamma;
        topCorner = betta;
      } else {
        bottomSide = sideC;
        leftSide = sideB;
        rightSide = sideA;
        leftCorner = alpha;
        rightCorner = betta;
        topCorner = gamma;
      }
      return;
    }

    if (triangle.sideA >= triangle.sideB && triangle.sideA >= triangle.sideC) {
      bottomSide = triangle.sideA;
      leftSide = triangle.sideB;
      rightSide = triangle.sideC;
      leftCorner = triangle.gamma;
      rightCorner = triangle.betta;
      topCorner = triangle.alpha;

      return;
    } else if (triangle.sideB >= triangle.sideA &&
        triangle.sideB >= triangle.sideC) {
      bottomSide = triangle.sideB;
      leftSide = triangle.sideC;
      rightSide = triangle.sideA;
      leftCorner = triangle.alpha;
      rightCorner = triangle.gamma;
      topCorner = triangle.betta;
      return;
    } else if (triangle.sideC >= triangle.sideA &&
        triangle.sideC >= triangle.sideB) {
      bottomSide = triangle.sideC;
      leftSide = triangle.sideA;
      rightSide = triangle.sideB;
      leftCorner = triangle.betta;
      rightCorner = triangle.alpha;
      topCorner = triangle.gamma;
      return;
    } else {
      return null;
    }
  }

  void findLastCornerDegree() {
    alpha == 0 ? alpha = 180 - betta - gamma : print('');
    betta == 0 ? betta = 180 - alpha - gamma : print('');
    gamma == 0 ? gamma = 180 - betta - alpha : print('');
  }

  double findSideByTwoSidesAndCornerBetween(
      {required double side1, required double side2, required double angle}) {
    double angleRadian = convertDegreeToRadian(angle);
    return math.sqrt(side1 * side1 +
        side2 * side2 -
        2 * side1 * side2 * math.cos(angleRadian));
  }

  double findSideByNearCornerDegreeAnd2Sides(
      {required double sideWithAngle,
      required double sideWithoutAngle,
      required double angleDegree}) {
    // double firstAngleRadian = convertDegreeToRadian(angleDegree);

    // step 1, find one more angle
    double secondAngleRadian = math.asin((sideWithAngle *
        math.sin(convertDegreeToRadian(angleDegree)) /
        sideWithoutAngle));

    if (secondAngleRadian > 0) {
      double thirdAngle =
          180 - angleDegree - convertRadianToDegree(secondAngleRadian);
      if (thirdAngle > 0) {
        isValid = true;
        return findSideByTwoSidesAndCornerBetween(
            side1: sideWithAngle, side2: sideWithoutAngle, angle: thirdAngle);
      }
    } else {
      isValid = false;
      message =
          'It is impossible to build an triangle with this data, try to change it';
    }
    return 0;
  }

  double findOppositeAngleToOppSideBy3sides(
      {required double oppositeSide,
      required double sideNearToAngle,
      required double side2NearToAngle}) {
    return convertRadianToDegree(
      math.acos(
        (math.pow(sideNearToAngle, 2) +
                math.pow(side2NearToAngle, 2) -
                math.pow(oppositeSide, 2)) /
            (2 * sideNearToAngle * side2NearToAngle),
      ),
    );
  }

  double findSideByTwoAnglesAndSide(
      {required sideToOppositeKnownCorner,
      required oppositeCorner,
      required oppositeKnownCornerToUnknownSide}) {
    return (sideToOppositeKnownCorner *
        math.sin(convertDegreeToRadian(oppositeKnownCornerToUnknownSide)) /
        math.sin(convertDegreeToRadian(oppositeCorner)));
  }

  void findAllBy2AnglesAndASide() {
    findLastCornerDegree();
    if (sideA == 0 && sideB == 0) {
      sideA = (sideC * math.sin(alpha.radians)) / math.sin(gamma.radians);
      sideB = (sideC * math.sin(betta.radians)) / math.sin(gamma.radians);
    } else if (sideA == 0 && sideC == 0) {
      sideA = (sideB * math.sin(alpha.radians)) / math.sin(betta.radians);
      sideC = (sideB * math.sin(gamma.radians)) / math.sin(betta.radians);
    } else if (sideB == 0 && sideC == 0) {
      sideB = (sideA * math.sin(betta.radians)) / math.sin(alpha.radians);
      sideC = (sideA * math.sin(gamma.radians)) / math.sin(alpha.radians);
    }
    ;
  }

  void findAllAnglesBySides({required sideA, required sideB, required sideC}) {
    if ((sideA + sideB) > sideC &&
        (sideB + sideC) > sideA &&
        (sideC + sideA) > sideB) {
      alpha = findOppositeAngleToOppSideBy3sides(
          oppositeSide: sideA, sideNearToAngle: sideB, side2NearToAngle: sideC);
      betta = findOppositeAngleToOppSideBy3sides(
          oppositeSide: sideB, sideNearToAngle: sideC, side2NearToAngle: sideA);
      gamma = findOppositeAngleToOppSideBy3sides(
          oppositeSide: sideC, sideNearToAngle: sideB, side2NearToAngle: sideA);
      if (alpha > 0 && betta > 0 && gamma > 0) {
        isValid = true;
        return;
      } else {
        isValid = false;
      }
    } else {
      //TODO: some alert to show mistake;
      isValid = false;
      message = 'Must be: a+b>c and b+c>a and c+a>b';
      return;
    }
  }

  DefineAction defAction(TriangleModel triangle) {
    if ((alpha + betta >= 180) ||
        (betta + gamma >= 180 || (gamma + alpha >= 180))) {
      message = 'two corners have to be less than 180$degreeSymbol';
      isValid = false;
      return DefineAction.none;
    }

    if ((alpha > 0 && betta > 0 && gamma > 0)) {
      if ((alpha + betta + gamma) != 180) {
        message = 'sum of angles have to be 180$degreeSymbol';
        isValid = false;
        return DefineAction.none;
      } else if (sideA == 0 && sideB == 0 && sideC == 0) {
        sideA = 1;
        message = 'three sides by proportion av 100';
        isValid = true;
        return DefineAction.threeAnglesAndASide;
      }
    }
    if (triangle.alpha > 0 &&
        triangle.betta > 0 &&
        triangle.gamma > 0 &&
        (sideA > 0 || sideB > 0 || sideC > 0)) {
      return DefineAction.threeAnglesAndASide;
    } else if (sideA > 0 && sideB > 0 && sideC > 0) {
      return DefineAction.threeSides;
    } else if ((sideA > 0 && sideB > 0 && gamma > 0) ||
        (sideB > 0 && sideC > 0 && alpha > 0) ||
        sideC > 0 && sideA > 0 && betta > 0) {
      return DefineAction.twoSidesAndCornerBetween;
    } else if ((sideA > 0 && sideB > 0 && (alpha > 0 || betta > 0)) ||
        (sideB > 0 && sideC > 0 && (betta > 0 || gamma > 0)) ||
        (sideC > 0 && sideA > 0 && (gamma > 0 || alpha > 0))) {
      return DefineAction.twoSidesAndCorner;
    } else if ((triangle.alpha > 0 && triangle.betta > 0) ||
        (triangle.alpha > 0 && triangle.gamma > 0) ||
        (triangle.betta > 0 && triangle.gamma > 0)) {
      return DefineAction.twoCornersAndASide;
    } else {
      return DefineAction.none;
    }
  }

  TriangleModel findAllData(TriangleModel triangle) {
    action = defAction(triangle);

    // print(action);

    switch (action) {
      case DefineAction.none:
        if (message == '') {
          message = 'At least 3 values need to build a triangle';
        }

        break;
      case DefineAction.twoCornersAndASide:
        findAllBy2AnglesAndASide();
        isValid = true;
        return triangle;
      case DefineAction.threeSides:
        findAllAnglesBySides(sideA: sideA, sideB: sideB, sideC: sideC);
        isValid = true;
        triangle.fillDrawData(triangle);
        return triangle;

      case DefineAction.threeAnglesAndASide:
        if (sideA > 0) {
          sideB = findSideByTwoAnglesAndSide(
              sideToOppositeKnownCorner: sideA,
              oppositeCorner: alpha,
              oppositeKnownCornerToUnknownSide: betta);
          sideC = findSideByTwoAnglesAndSide(
              sideToOppositeKnownCorner: sideA,
              oppositeCorner: alpha,
              oppositeKnownCornerToUnknownSide: gamma);
        } else if (sideB > 0) {
          sideA = findSideByTwoAnglesAndSide(
              sideToOppositeKnownCorner: sideB,
              oppositeCorner: betta,
              oppositeKnownCornerToUnknownSide: alpha);
          sideC = findSideByTwoAnglesAndSide(
              sideToOppositeKnownCorner: sideB,
              oppositeCorner: betta,
              oppositeKnownCornerToUnknownSide: gamma);
        } else if (sideC > 0) {
          sideA = findSideByTwoAnglesAndSide(
              sideToOppositeKnownCorner: sideC,
              oppositeCorner: gamma,
              oppositeKnownCornerToUnknownSide: alpha);
          sideB = findSideByTwoAnglesAndSide(
              sideToOppositeKnownCorner: sideC,
              oppositeCorner: gamma,
              oppositeKnownCornerToUnknownSide: betta);
        }
        isValid = true;
        triangle.fillDrawData(triangle);
        break;
      case DefineAction.twoSidesAndCornerBetween:
        if (sideA > 0 && sideB > 0 && gamma > 0) {
          sideC = findSideByTwoSidesAndCornerBetween(
              side1: sideA, side2: sideB, angle: gamma);
          findAllAnglesBySides(sideA: sideA, sideB: sideB, sideC: sideC);
        } else if (sideB > 0 && sideC > 0 && alpha > 0) {
          sideA = findSideByTwoSidesAndCornerBetween(
              side1: sideB, side2: sideC, angle: alpha);
          findAllAnglesBySides(sideA: sideA, sideB: sideB, sideC: sideC);
        } else if (sideC > 0 && sideA > 0 && betta > 0) {
          sideB = findSideByTwoSidesAndCornerBetween(
              side1: sideC, side2: sideA, angle: betta);
          findAllAnglesBySides(sideA: sideA, sideB: sideB, sideC: sideC);
        }
        // fillDrawData(triangle);
        return triangle;
      // break;
      case DefineAction.twoSidesAndCorner:
        if (sideA > 0 && sideB > 0 && (alpha > 0 || betta > 0)) {
          if (alpha > 0) {
            sideC = findSideByNearCornerDegreeAnd2Sides(
                sideWithAngle: sideB,
                sideWithoutAngle: sideA,
                angleDegree: alpha);
            if (sideC > 0) {
              findAllAnglesBySides(sideA: sideA, sideB: sideB, sideC: sideC);
            }
          } else {
            sideC = findSideByNearCornerDegreeAnd2Sides(
                sideWithAngle: sideA,
                sideWithoutAngle: sideB,
                angleDegree: betta);
            if (sideC > 0) {
              findAllAnglesBySides(sideA: sideA, sideB: sideB, sideC: sideC);
            }
          }
        } else if (sideB > 0 && sideC > 0 && (betta > 0 || gamma > 0)) {
          if (betta > 0) {
            sideA = findSideByNearCornerDegreeAnd2Sides(
                sideWithAngle: sideC,
                sideWithoutAngle: sideB,
                angleDegree: betta);
            if (sideA > 0) {
              findAllAnglesBySides(sideA: sideA, sideB: sideB, sideC: sideC);
            }
          } else {
            sideA = findSideByNearCornerDegreeAnd2Sides(
                sideWithAngle: sideB,
                sideWithoutAngle: sideC,
                angleDegree: gamma);
            if (sideA > 0) {
              findAllAnglesBySides(sideA: sideA, sideB: sideB, sideC: sideC);
            }
          }
        } else if (sideC > 0 && sideA > 0 && (alpha > 0 || gamma > 0)) {
          if (alpha > 0) {
            sideB = findSideByNearCornerDegreeAnd2Sides(
                sideWithAngle: sideC,
                sideWithoutAngle: sideA,
                angleDegree: alpha);
            if (sideB > 0) {
              findAllAnglesBySides(sideA: sideA, sideB: sideB, sideC: sideC);
            }
          } else {
            sideB = findSideByNearCornerDegreeAnd2Sides(
                sideWithAngle: sideA,
                sideWithoutAngle: sideC,
                angleDegree: gamma);
            if (sideB > 0) {
              findAllAnglesBySides(sideA: sideA, sideB: sideB, sideC: sideC);
            }
          }
        }
        break;
    }

    // print(
    //     '$action : alpha = $alpha, betta = $betta, gamma = $gamma, sideA = $sideA, sideB = $sideB, sideC = $sideC, largestSide = $largestSide');
    fillDrawData(triangle);
    return triangle;
  }
}

extension on num {
  /// This is an extension we created so we can easily convert a value  /// to a radian value
  double get radians => (this * math.pi) / 180.0;
}

extension FancyIterable on Iterable<int> {
  int get max => reduce(math.max);

  int get min => reduce(math.min);
}
